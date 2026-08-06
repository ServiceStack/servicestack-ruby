# Changelog

All notable changes to this project will be documented in this file.

## [0.1.2]

### Added

- `on_authentication_required` callback for re-authenticating a client before
  automatically retrying a Request that returned 401 Unauthorized

## [0.1.1]

### Added

- `post_file_with_request` and `post_files_with_request` for uploading files with
  a Request DTO as a `multipart/form-data` Request, incl. an `UploadFile` that
  accepts file contents as a String or any IO
- `post_files_with_request_url` for uploading files to a custom URL

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

[0.1.2]: https://github.com/ServiceStack/servicestack-ruby/releases/tag/v0.1.2
[0.1.1]: https://github.com/ServiceStack/servicestack-ruby/releases/tag/v0.1.1
[0.1.0]: https://github.com/ServiceStack/servicestack-ruby/releases/tag/v0.1.0
