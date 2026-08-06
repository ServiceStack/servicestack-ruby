# frozen_string_literal: true

require_relative 'lib/servicestack/version'

Gem::Specification.new do |spec|
  spec.name = 'servicestack'
  spec.version = ServiceStack::VERSION
  spec.authors = ['ServiceStack']
  spec.email = ['team@servicestack.net']

  spec.summary = 'Typed Ruby Client Library for consuming ServiceStack APIs'
  spec.description = 'Send generated typed Request DTOs to any ServiceStack API, with ' \
                     'structured ResponseStatus errors, AutoQuery, batched Requests and ' \
                     'Bearer Token, API Key, Basic Auth and Session Cookie authentication.'
  spec.homepage = 'https://github.com/ServiceStack/servicestack-ruby'
  spec.license = 'BSD-3-Clause'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'false'

  spec.files = Dir['lib/**/*.rb', 'README.md', 'CHANGELOG.md', 'LICENSE']
  spec.require_paths = ['lib']

  # Only uses the Ruby standard library
end
