# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chuyo/version'

Gem::Specification.new do |spec|
  spec.name          = "chuyo"
  spec.version       = Chuyo::VERSION
  spec.authors       = ["Pablo Torres"]
  spec.email         = ["tn.pablo@gmail.com"]
  spec.description   = %q{A toy web framework}
  spec.summary       = %q{A toy web framework}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "erubis"
end
