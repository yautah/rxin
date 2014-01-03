# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rxin/version'

Gem::Specification.new do |spec|
  spec.name          = "rxin"
  spec.version       = Rxin::VERSION
  spec.authors       = ["Yang Quan"]
  spec.email         = ["feza@163.com"]
  spec.description   = %q{weixin social platform api sdk for ruby}
  spec.summary       = %q{weixin social platform api sdk for ruby}
  spec.homepage      = "http://github.com/yautah/rxin"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'
  spec.add_dependency 'multi_json'
  spec.add_dependency 'roxml'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 2.6"
end
