# Git Smash

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/iwishiwasaneagle/git-release/master.svg)](https://results.pre-commit.ci/latest/github/iwishiwasaneagle/git-release/master)
[![CI](https://github.com/iwishiwasaneagle/git-release/actions/workflows/CI.yml/badge.svg)](https://github.com/iwishiwasaneagle/git-release/actions/workflows/CI.yml)
[![License](https://img.shields.io/github/license/iwishiwasaneagle/git-release)](https://github.com/iwishiwasaneagle/git-release/blob/master/LICENSE.txt)

Easily generate releases using [`git-cliff`](https://github.com/orhun/git-cliff) and [github actions](https://github.com/iwishiwasaneagle/git-release/blob/master/.github/workflows/CD.yml)

## Installation

```bash
cargo install git-cliff

sudo make install
```

## Example

Installing `git-release` and using it  to create [v0.0.1](https://github.com/iwishiwasaneagle/git-release/releases/tag/v0.0.1):

```bash
sudo make install
git release v0.0.1
```

<details>
<summary>Output</summary>

```bash
pre-commit uninstalled
 WARN  git_cliff > "cliff.toml" is not found, using the default configuration.
[master 6eaaa01] chore(release): prepare for v0.0.1 [skip pre-commit.ci]
 1 file changed, 45 insertions(+)
 create mode 100644 CHANGELOG.md
commit 6eaaa013c32677387ab588f82853c849f36a65e6
Author: iwishiwasaneagle <jh.ewers@gmail.com>
Date:   Wed Apr 20 11:36:24 2022 +0100

    chore(release): prepare for v0.0.1 [skip pre-commit.ci]

    Signed-off-by: iwishiwasaneagle <jh.ewers@gmail.com>

diff --git a/CHANGELOG.md b/CHANGELOG.md
new file mode 100644
index 0000000..1bca1d6
--- /dev/null
+++ b/CHANGELOG.md
@@ -0,0 +1,45 @@
+# Changelog
+
+All notable changes to this project will be documented in this file.
+
+## [0.0.1] - 2022-04-20
+
+### Bug Fixes
+
+- Add flow to check if changelog.md exists already within git
+- Cannot pass 'latest' to --version
+- Various errors
+- Use random semver that won't (probably) ever be used
+- Don't sign release in CI
+- Skip git tag -v if no-sign is set
+- Typo
+- Disable caching in CI until I can be bothered to fix it
+- Use matrix.os in cache as older os's wouldn't have the same packages
+
+### Documentation
+
+- Update README
+
+### Features
+
+- Push current branch and tag at the same time
+- CD workflow
+
+### Performance
+
+- Move to actions-rs/install to leverage cache
+- Cache cargo in CI
+- Invalidate cache every week
+
+### Refactor
+
+- Use heredoc for template
+- Use heredoc for template
+
+### Testing
+
+- Setup test env correctly
+- Use built-in cargo
+- Remove -x flag
+
+<!-- generated by git-cliff -->
 WARN  git_cliff > "cliff.toml" is not found, using the default configuration.
gpg: Signature made Wed 20 Apr 2022 11:36:24 BST
gpg:                using RSA key 5847BEFCE1FE5D11DDF96BE594E285A7335EDA83
gpg: Good signature from "iwishiwasaneagle (Jan-Hendrik Ewers) <jh.ewers@gmail.com>" [ultimate]
object 6eaaa013c32677387ab588f82853c849f36a65e6
type commit
tag v0.0.1
tagger iwishiwasaneagle <jh.ewers@gmail.com> 1650450984 +0100

Release v0.0.1

Bug Fixes

- Add flow to check if changelog.md exists already within git (4f3283f)

- Cannot pass 'latest' to --version (f7ec4f2)

- Various errors (0929ba3)

- Use random semver that won't (probably) ever be used (2175c74)

- Don't sign release in CI (69a512c)

- Skip git tag -v if no-sign is set (4df3b9c)

- Typo (cda1a26)

- Disable caching in CI until I can be bothered to fix it (453d883)

- Use matrix.os in cache as older os's wouldn't have the same packages (f0bb515)

Documentation

- Update README (8d3f455)

Features

- Push current branch and tag at the same time (a4cbb08)

- CD workflow (d521b06)

Performance

- Move to actions-rs/install to leverage cache (f96fd73)

- Cache cargo in CI (23fa2f8)

- Invalidate cache every week (a03ddf9)

Refactor

- Use heredoc for template (eb850ba)

- Use heredoc for template (7ca46c6)

Testing

- Setup test env correctly (6d7c97c)

- Use built-in cargo (56105b0)

- Remove -x flag (00c1999)

"
To github.com:iwishiwasaneagle/git-release.git
   f0bb515..6eaaa01  master -> master
 * [new tag]         v0.0.1 -> v0.0.1
pre-commit installed at .git/hooks/pre-commit
```

</details>

## Repos that have used git-release

- [iwishiwasaneagle/jsim](https://github.com/iwishiwasaneagle/jsim)
