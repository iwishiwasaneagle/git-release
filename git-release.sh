#!/bin/bash

set -e

function usage() {
    cat<<HELPUSAGE
git release [options] <tagname>

Options
    --verify       Run git hooks. Default skips. WARNING: Tags and that may need to be deleted if a hook is run and it fails the push/tag creation/commit/etc.
    --no-skip-ci   Don't add a message to the commit to skip the pre-commit ci (only relevant if you are using pre-commit ci)
    --no-semver    Don't check if the tag is semver compatible (i.e. v9.2.3)

Tag options
    -m, --message <message>   Tag message (defaults to changelog)
    --no-sign                 Don't sign the tag

HELPUSAGE
}

MESSAGE=""
SKIP_CI="[skip pre-commit.ci]"
SIGN="-s"
NOVERIFY="--no-verify"
SEMVERCHECK=1

TEMP=$(getopt -n release --long no-semver,help,verify,no-sign,skip-ci,message: -o hm: -- "$@")
eval set -- "$TEMP"

while true; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        --no-semver)
            SEMVERCHECK=0
            shift 1;
            ;;
        -m | --message )
            MESSAGE="$2"
            shift 2;
            ;;
        --no-skip-ci )
            SKIP_CI=""
            shift 1;
            ;;
        --no-sign )
            SIGN=""
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

set +e
SEMVERCOUNTS=$(echo $1 | grep -oPc "^v?(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)$")
set -e
echo $SEMVERCOUNTS
if [[ $SEMVERCHECK -eq 1 && $SEMVERCOUNTS -ne 1 ]]; then
    echo "Invalid semantic version \"$1\". Use --no-semver if you would like to use it regardless"
    exit 1
fi

if command -v pre-commit &> /dev/null; then
    pre-commit uninstall
fi

CHANGELOG_FILE="CHANGELOG.md"
git-cliff --tag "$1" > "$CHANGELOG_FILE"
if ! git ls-files --error-unmatch "$CHANGELOG_FILE" &> /dev/null; then
    git add "$CHANGELOG_FILE"
fi
git commit $SIGN "$CHANGELOG_FILE" -m "chore(release): prepare for $1 $SKIP_CI"
git show

# generate a changelog for the tag message based on the following template
export TEMPLATE=$(cat <<END
{% for group, commits in commits | group_by(attribute="group") %}
{{ group | upper_first }}
{% for commit in commits %}
- {{ commit.message | upper_first }} ({{ commit.id | truncate(length=7, end="") }})
{% endfor %}
{% endfor %}
END
)

if [[ -z "$MESSAGE" ]]; then
    MESSAGE=$(git-cliff --unreleased --strip all)
fi

# create a signed tag
git tag $SIGN -a "$1" -m "Release $1" -m "$MESSAGE"
if [[ ! -z "$SIGN" ]]; then
    git tag -v "$1"
fi
git push $NOVERIFY origin $(git branch --show-current) "$1"

if command -v pre-commit &> /dev/null; then
    pre-commit install
fi
