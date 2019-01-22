# Changelog


Changes to this gem will be noted here.

## [0.3.0] - 2019-01-22

### Changed

- Upgraded httpi to 2.4.4.

### Added
- User resource endpoint.
- Route resource endpoint.

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