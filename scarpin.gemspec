# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scarpin/version'

Gem::Specification.new do |spec|
  spec.name          = 'scarpin'
  spec.version       = Scarpin::VERSION
  spec.authors       = ['Ryan Breed']
  spec.email         = ['opensource@breed.org']

  spec.summary       = %q{ Stub API for redseal + convenience routines }
  spec.description   = %q{ Integration API for getting data into/out of RedSeal API }
  spec.homepage      = 'https://github.com/ryanbreed/scarpin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'nori'
  spec.add_dependency 'gyoku'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-bundler-audit'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'

end
