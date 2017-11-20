# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qonto/version'

Gem::Specification.new do |spec|
  spec.name     = 'qonto'
  spec.version  = Qonto::VERSION
  spec.authors  = ['Sébastien Charrier']
  spec.email    = ['scharrier@gmail.com']
  spec.licenses = ['MIT']

  spec.summary  = 'A Ruby client for the Qonto Api.'
  spec.homepage = 'https://github.com/scharrier/qonto-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_runtime_dependency 'httparty', '~> 0.10'

  spec.add_development_dependency 'rake', '~> 12'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'webmock', '~> 3'
end
