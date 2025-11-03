# frozen_string_literal: true

require_relative "lib/servicestack/version"

Gem::Specification.new do |spec|
  spec.name = "servicestack"
  spec.version = ServiceStack::VERSION
  spec.authors = ["ServiceStack"]
  spec.email = ["team@servicestack.net"]

  spec.summary = "ServiceStack Ruby HTTP Client Library"
  spec.description = "Ruby HTTP Client for consuming ServiceStack web services"
  spec.homepage = "https://github.com/ServiceStack/servicestack-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ServiceStack/servicestack-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/ServiceStack/servicestack-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  # Using only Ruby standard library for HTTP client
  
  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
