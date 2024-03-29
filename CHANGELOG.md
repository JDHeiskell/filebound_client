# Changelog


Changes to this gem will be noted here.

## [0.4.4] - 2023-03-13

### Changed

- Upgraded HTTPI and bundler
- Upgraded Rack

## [0.4.1] - 2021-01-13

### Changed

- Allowed for the possibility that the Filebound API may return an empty string in the response body

### Added

- Spec for creating a document note

## [0.4.0] - 2020-12-30

### Added

- Created FileboundClient::Endpoints::Documents#document_comments for retrieve comments for a document
- Created FileboundClient::Endpoints::Documents#document_add_comment for creating new comments on a document
- Created FileboundClient::Endpoints::Files#file_comments for retrieve comments for a file
- Created FileboundClient::Endpoints::Files#file_add_comment for creating new comments on a file

## [0.3.8] - 2020-04-15

### Changed

- Updated bundler to 2.1.4
- Updated gem dependencies to latest versions

## [0.3.7] - 2019-07-29

### Changed

- Updated yard to fix a security vulnerability (https://github.com/lsegal/yard/security/advisories/GHSA-xfhh-rx56-rxcr)
- Updated bundler to 1.17.3

## [0.3.6] - 2019-06-06

### Added

- Partially implemented Groups endpoint

## [0.3.5] - 2019-03-20

### Changed

- Enabled quirks mode on the JSON parser for all responses being parsed.

## [0.3.4] - 2019-03-20

### Changed

- Enabled quirks mode on the JSON parser in FileboundClient::Connection#login

## [0.3.3] - 2019-02-01

### Removed

- Unnecessary logger config.

## [0.3.2] - 2019-01-31

### Added
- Improved error information returned when and API call fails.

## [0.3.1] - 2019-01-23

### Added
- Call to get single routed item.

## [0.3.0] - 2019-01-22

### Changed

- Upgraded httpi to 2.4.4.

### Added
- User resource endpoint.
- Route resource endpoint.
- RoutedItem resource endpoint.

## [0.2.0] - 2018-08-07
### Changed
- Replaced ruby-ntlm dependency with httpi.  httpi gem is actively being developed while ruby-ntlm hasn't had a new
  release in over a year.

### Added
- Query resource endpoint.

## [0.1.1] - 2018-08-01
### Fixed
- Fixed error in summary in the gemspec file.

## [0.1.0] - 2018-08-01
### Added
- Assignments, Dividers, DocumentBinaryData, Documents, EFormData, EFormDetail, Files, Projects, Separators, and Version
  endpoints.
- Initial build of client and configuration code
- Specs for assignments, dividers, documents, projects, and separators endpoints and FileboundClient::Client.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).