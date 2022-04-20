#!/bin/bash

set -e

function usage() {
    cat<<HELPUSAGE
git release [options] <tagname>

Options
        --verify       Run git hooks. Default skips. WARNING: Tags and that may need to be deleted if a hook is run and it fails the push/tag creation/commit/etc.
        --skip-cli     Add a message to the commit to skip the pre-commit ci (only relevant if you are using pre-commit ci

Tag options
        -m, --message <message>   Tag message (defaults to changelog)
        -s                        Sign the tag

HELPUSAGE
}

MESSAGE=""
SKIP_CLI=""
SIGN=""
NOVERIFY="--no-verify"

TEMP=$(getopt -n release --long help,verify,skip-cli,message: -o shm: -- "$@")
eval set -- "$TEMP"

while true; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -m | --message )
            MESSAGE="$2"
            shift 2;
            ;;
        --skip-cli )
            SKIP_CLI="[skip pre-commit.ci]"
            shift 1;
            ;;
        -s )
            SIGN="-s"
            shift 1;
            ;;
        --verify )
            NOVERIFY="";
            shift 1;
            ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

if command -v pre-commit &> /dev/null; then
    pre-commit uninstall
fi

CHANGELOG_FILE="CHANGELOG.md"
git-cliff --tag "$1" > "$CHANGELOG_FILE"
if ! git ls-files --error-unmatch "$CHANGELOG_FILE" &> /dev/null; then
    git add "$CHANGELOG_FILE"
fi
git commit "$CHANGELOG_FILE" -m "chore(release): prepare for $1 $SKIP_CLI"
git show

# generate a changelog for the tag message based on the following template
export TEMPLATE=$(cat <<END
{% for group, commits in commits | group_by(attribute="group") %}
{{ group | upper_first }}
{% for commit in commits %}
- {{ commit.message | upper_first }} ({{ commit.id | truncate(length=7, end="") }})
{% endfor %}
{% endfor %}"
END
)

if [[ -z "$MESSAGE" ]]; then
    MESSAGE=$(git-cliff --unreleased --strip all)
fi

# create a signed tag
git tag "$SIGN" -a "$1" -m "Release $1" -m "$MESSAGE"
git tag -v "$1"
git push "$NOVERIFY" origin $(git branch --show-current) "$1"

if command -v pre-commit &> /dev/null; then
    pre-commit install
fi
