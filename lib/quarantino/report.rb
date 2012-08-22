module Quarantino
	class Report
		attr_reader :attributes

		class << self
			def create(params)
				Quarantino.new(params)
			end
		end

		def initialize(params)
			@attributes ||= request(params)
		end

		private

		def request(params)
			validate(params)
      
      response = connection.post do |req|
			  req.url '/reports'
			  req.headers['Content-Type'] = 'application/json'
			  req.headers['X-API-Key'] = ENV['QUARANTINO_API_KEY'] if ENV['QUARANTINO_API_KEY']
			  req.body = {session_attributes: params}.to_json
			end

			JSON.parse(response.body)
		end

		def connection
			@connection ||= Faraday.new(:url => 'http://quarantino.herokuapp.com')
		end

		def validate(params)
			raise ArgumentError, "Please configure QUARANTINO_API_KEY in your environment." unless ENV['QUARANTINO_API_KEY']
		end
	end
end