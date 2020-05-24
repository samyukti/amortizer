# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amortizer/version'

Gem::Specification.new do |spec|
  spec.name          = "amortizer"
  spec.version       = Amortizer::VERSION
  spec.authors       = ["Geordee Naliyath"]
  spec.email         = ["geordee@gmail.com"]
  spec.summary       = %q{A simple gem to calculate amortizing loan payments.}
  spec.description   = %q{A simple gem to calculate amortizing loan payments, as part of training at Samyukti}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bigdecimal"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
