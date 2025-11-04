# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-03

### Added
- Initial release of ServiceStack Ruby Client
- `JsonServiceClient` class for making HTTP requests to ServiceStack services
- Support for all HTTP methods (GET, POST, PUT, DELETE, PATCH)
- Typed Request/Response DTO support
- Basic Authentication support
- Bearer Token Authentication support
- Custom headers support
- ServiceStack error response handling with `WebServiceException`
- `ResponseStatus` DTO for error details
- Automatic JSON serialization/deserialization
- Query string parameters for GET requests
- Configurable timeout support
- Comprehensive test suite
- Example files demonstrating usage patterns
- Documentation and README

[1.0.0]: https://github.com/ServiceStack/servicestack-ruby/releases/tag/v1.0.0
## [Unreleased]

## [0.1.0] - 2024-11-03

### Added
- Initial release of ServiceStack Ruby HTTP Client Library
- HTTP client supporting GET, POST, PUT, PATCH, and DELETE methods
- JSON request/response handling
- Configurable timeouts
- Error handling for HTTP responses
- Comprehensive test suite
