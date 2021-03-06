# Changelog

All notable changes to this project will be documented in this file.

## [0.2.1] - 2022-06-02

### Bug Fixes

- Cache key for cargo that invalidates weekly
- Was always incrementing minor

### Documentation

- Codecov badge

### Miscellaneous Tasks

- Delete legacy file

### Testing

- Install git-cliff during CI

## [0.2.0] - 2022-05-11

### Bug Fixes

- Method of comparing semvers was flawed. Needed constant shift value otherwise 0.0.10 > 0.1.0 as 0.1.1 would be assigned 3 and  0.0.10 would be assigned 10
- Make  updating  minor default to  stay within semver 2.0 guidlines
- Don't find git-cliff binary twice

### Documentation

- Pypi shields

### Miscellaneous Tasks

- Update changelog for v0.2.0 [skip pre-commit.ci]

### Refator

- Handle getting current semver better. means -h can be called outwith a repo

## [0.1.0] - 2022-04-25

### Documentation

- Update README

### Miscellaneous Tasks

- Update changelog for v0.1.0 [skip pre-commit.ci]

## [0.0.10] - 2022-04-25

### Miscellaneous Tasks

- Update changelog for v0.0.10 [skip pre-commit.ci]

## [0.0.9] - 2022-04-25

### Miscellaneous Tasks

- Update changelog for v0.0.8 [skip pre-commit.ci]

## [0.0.7] - 2022-04-25

### Miscellaneous Tasks

- Update changelog for v0.0.7 [skip pre-commit.ci]

## [0.0.6] - 2022-04-25

### Bug Fixes

- Remove upper limit on python version
- --no-verify as standard

### Features

- Python CI  and CD
- Dependabot

### Miscellaneous Tasks

- Update changelog for v0.0.6 [skip pre-commit.ci]

## [0.0.5] - 2022-04-24

### Bug Fixes

- Show version from CLI
- Remove version from CLI and rely on dynamic fetch
- Scratch showing version at runtime for now

### Features

- --comment flag
- Moved to python
- Automated versioning

### Miscellaneous Tasks

- Update changelog for v0.0.5 [skip pre-commit.ci]

## [0.0.4] - 2022-04-24

### Miscellaneous Tasks

- Add logging
- Update changelog [skip pre-commit.ci]
- Update changelog [skip pre-commit.ci]
- Update changelog [skip pre-commit.ci]
- More information in changelog commit
- Update changelog for v0.0.4 [skip pre-commit.ci]

## [0.0.3] - 2022-04-24

### Miscellaneous Tasks

- Update changelog [skip pre-commit.ci]

## [0.0.2] - 2022-04-24

### Bug Fixes

- Only upload desired files
- Title
- Floating "
- Disable gpgsigning in CI via git config (also use --no-sign)

### Documentation

- Example usage
- Add supported os
- Add section on contributing

### Features

- Add macos to supported os
- Convert to python from bash

### Miscellaneous Tasks

- Python gitignore
- Update changelog [skip pre-commit.ci]

### Testing

- Auto-generate  GPG key for git user to enable signing in tests
- Auto-generate  GPG key for git user to enable signing in tests
- Auto-generate  GPG key for git user to enable signing in tests (attempt 2)
- Use my own action git-user-random-gpg-key

## [0.0.1] - 2022-04-20

### Bug Fixes

- Add flow to check if changelog.md exists already within git
- Cannot pass 'latest' to --version
- Various errors
- Use random semver that won't (probably) ever be used
- Don't sign release in CI
- Skip git tag -v if no-sign is set
- Typo
- Disable caching in CI until I can be bothered to fix it
- Use matrix.os in cache as older os's wouldn't have the same packages

### Documentation

- Update README

### Features

- Push current branch and tag at the same time
- CD workflow

### Performance

- Move to actions-rs/install to leverage cache
- Cache cargo in CI
- Invalidate cache every week

### Refactor

- Use heredoc for template
- Use heredoc for template

### Testing

- Setup test env correctly
- Use built-in cargo
- Remove -x flag

<!-- generated by git-cliff -->
