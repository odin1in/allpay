# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'allpay/version'

Gem::Specification.new do |spec|
  spec.name          = "allpay"
  spec.version       = Allpay::VERSION
  spec.authors       = ["odin1in"]
  spec.email         = ["odin@pwn.so"]
  spec.summary       = %q{Allpay API}
  spec.description   = %q{Allpay vAccount API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '~> 0'
  spec.add_runtime_dependency 'nori', '~> 2.4.0', '>= 2.4.0'
  spec.add_runtime_dependency 'gyoku', '~> 1.0'
  spec.add_runtime_dependency 'addressable', '~> 2.3.6', '>= 2.3.6'
end
