# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "railyard/version"

Gem::Specification.new do |spec|
  spec.name          = "railyard"
  spec.version       = Railyard::VERSION
  spec.authors       = ["Brandon Weiss"]
  spec.email         = ["brandon@anti-pattern.com"]
  spec.summary       = %q{Non-polluting Rails skeleton generator}
  spec.description   = %q{Generate Rails skeletons without having to globally install Rails and its bajillion dependencies.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.3.2"

  spec.add_dependency "bundler", "~> 1.7"
  spec.add_dependency "thor",    "~> 0.19.1"
end
