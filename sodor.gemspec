
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sodor/version'

Gem::Specification.new do |spec|
  spec.name          = 'sodor'
  spec.version       = Sodor::VERSION
  spec.authors       = ['Topham Hatt']
  spec.email         = ['topham@nwrail.com']

  spec.summary       = 'Prototype rail app for the North Western Railway in Sodor'
  spec.description   = 'Prototype rail app for the North Western Railway in Sodor'
  spec.homepage      = 'http://nwrail.com'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://localhost'
    spec.metadata['yard.run'] = 'yri'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = 'sodor'
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.16.1'
  spec.add_development_dependency 'rake', '~> 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'yard', '~> 0.9.12'
end
