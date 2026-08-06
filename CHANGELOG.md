# Changelog

All notable changes to this project will be documented in this file.

## [0.1.0]

### Added

- `ServiceStack::JsonServiceClient` for consuming ServiceStack APIs with
  generated typed DTOs
- `ServiceStack::DTO` conversions driven by the wire name and Type metadata
  generated DTOs declare, so nested DTOs, Dates and collections round-trip
- Structured `ResponseStatus` errors in `WebServiceException`, incl. field errors
- `api` results that return errors instead of raising
- Auth with Basic Auth, API Keys, Bearer Tokens, Refresh Tokens and Session Cookies
- Batched (`send_all`), one-way (`publish`) and custom URL Requests
- Built-in ServiceStack DTOs referenced by generated DTOs (`ResponseStatus`,
  `QueryBase`, `QueryResponse`, `Authenticate`, ...)

[0.1.0]: https://github.com/ServiceStack/servicestack-ruby/releases/tag/v0.1.0
