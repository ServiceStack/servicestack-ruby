Gem::Specification.new do |spec|
  spec.name          = "servicestack-client"
  spec.version       = "1.0.0"
  spec.authors       = ["ServiceStack"]
  spec.email         = ["team@servicestack.net"]

  spec.summary       = "Ruby ServiceStack Client"
  spec.description   = "ServiceStack JsonServiceClient for Ruby - make typed API requests using ServiceStack DTOs"
  spec.homepage      = "https://github.com/ServiceStack/servicestack-ruby"
  spec.license       = "BSD-3-Clause"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ServiceStack/servicestack-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/ServiceStack/servicestack-ruby/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 2.0"
end
