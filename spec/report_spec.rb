require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Quarantino::Report do

  before do
    stub_request(
      :post,
      "http://quarantino.herokuapp.com/reports"
    ).to_return(
      :status => 200,
      :body => File.open('./spec/support/responses/report.json')
    )

    @session_attributes = {
       "ip"=>"93.54.11.50", 
       "city"=>"London",
       "region"=>"London",
       "postal_code"=>"EC1N 2JT",
       "country"=>"United Kingdom",
       "forwarded_ip"=>nil, "email_md5"=>"ANB",
       "username_md5"=>"ASD",
       "password_md5"=>"[FILTERED]",
       "app_session_id"=>"1234",
       "user_agent"=>"Mozilla",
       "accept_language"=>"English-US"
     }
  end

  describe "#new" do
    it "requests a report" do
      report = Quarantino::Report.new(@session_attributes)
    end

    it "uses the API_KEY environment variable" do
      with_env 'QUARANTINO_API_KEY', 'ABC' do
        report = Quarantino::Report.new(@session_attributes)

        a_request(
          :post,
          "http://quarantino.herokuapp.com/reports"
        ).with(
          :headers => {'Content-Type' => 'application/json', 'X-API-Key' => ENV['QUARANTINO_API_KEY']}
        ).should have_been_made
      end
    end

    it "warns about a missing API_KEY environment variable" do
      with_env 'QUARANTINO_API_KEY', nil do
        lambda {
          report = Quarantino::Report.new(@session_attributes)
        }.should raise_error ArgumentError

        a_request(
          :post,
          "http://quarantino.herokuapp.com/reports"
        ).should_not have_been_made
      end
    end
  end

  describe "#attributes" do
    it "sets the attributes from the report" do
      report = Quarantino::Report.new(@session_attributes)
      report.attributes.should == JSON.parse(File.open('./spec/support/responses/report.json').read)
    end
  end

  def with_env(key, value, &block)
    old_env = ENV[key]
    ENV[key] = value
    yield
    ENV[key] = old_env
  end
end