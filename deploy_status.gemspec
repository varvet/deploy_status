# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deploy_status/version'

Gem::Specification.new do |spec|
  spec.name          = "deploy_status"
  spec.version       = DeployStatus::VERSION
  spec.authors       = ["Mattias Warnqvist"]
  spec.email         = ["mwq@mwq.se"]
  spec.summary       = %q{common capistrano tasks}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "sinatra"
end
