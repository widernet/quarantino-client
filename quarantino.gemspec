# -*- encoding: utf-8 -*-
require File.expand_path('../lib/quarantino/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sam Oliver"]
  gem.email         = ["sam@samoliver.com"]
  gem.description   = "Client for Quarantino"
  gem.summary       = ""
  gem.homepage      = "http://github.com/widernet/quarantino-client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "quarantino"
  gem.require_paths = ["lib"]
  gem.version       = Quarantino::VERSION

  gem.add_dependency "faraday"
  gem.add_dependency "json"
  gem.add_development_dependency "rspec", ">= 1.2.9"
  gem.add_development_dependency "webmock"
end
