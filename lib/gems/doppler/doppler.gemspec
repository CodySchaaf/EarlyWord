# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doppler/version'

Gem::Specification.new do |spec|
  spec.name          = "doppler"
  spec.version       = Doppler::VERSION
  spec.authors       = ["Cody Schaaf"]
  spec.email         = ["codyjschaaf@gmail.com"]
  spec.summary       = %q{Handles requests for weather data from wunderground.}
  spec.description   = %q{Optional}
  spec.homepage      = "https://github.com/CodySchaaf"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
