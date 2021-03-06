# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_rack_logger/version'

Gem::Specification.new do |gem|
  gem.name        = "simple-rack-logger"
  gem.version     = SimpleRackLogger::VERSION
  gem.authors     = ["Adriano Dadario"]
  gem.email       = ["dadario@gmail.com"]
  gem.description = %q{A simple rack for log information from environment.}
  gem.summary     = %q{For use in Rack application to log information from environment. Special from request data}
  gem.homepage    = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'uuid'

  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-inotify', '~> 0.8.8'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'rack-test'

end
