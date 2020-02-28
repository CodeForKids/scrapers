# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrapers/version'

Gem::Specification.new do |spec|
  spec.name          = "scrapers"
  spec.version       = Scrapers::VERSION
  spec.authors       = ["Julian Nadeau"]
  spec.email         = ["julian.nadeau@shopify.com"]
  spec.summary       = %q{A Scrapers Library for the Code For Kids Aggregation app.}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
end
