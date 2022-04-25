Easily generate tag-based releases. Uses the powerful [`git-cliff`](https://github.com/orhun/git-cliff) to generate changelogs. These can then be leveraged via [github actions](https://github.com/iwishiwasaneagle/git-release/blob/master/.github/workflows/CD.yml)
pip install git-release
usage: git-release [-h] [--comment COMMENT] [--remote REMOTE] [-v] [--semver SEMVER] [--major | --minor | --patch | --no-inc]

optional arguments:
  -h, --help            show this help message and exit
  --comment COMMENT, -c COMMENT
                        A comment to describe the release. Synonymous to a tag message. Defaults to the generated changelog.
  --remote REMOTE, -r REMOTE
                        The repository remote (defaults to 'origin')
  -v, --verbose         NOT IMPLEMENTED YET

Semantic Version:
  Options to manipulate the version. If --semver is not passed, git-release uses the most recent tag.

  --semver SEMVER       Custom semantic version. Use --no-inc to use as is.
  --major, -M           Increment the major version by 1 (resets minor and patch)
  --minor, -m           Increment the minor version by 1 (resets patch)
  --patch, -P           Increment the patch version by 1 (default behaviour)
  --no-inc              Don't increment anything