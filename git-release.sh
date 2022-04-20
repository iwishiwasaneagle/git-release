#!/bin/bash

set -e

function usage() {
    cat<<HELPUSAGE
git release [options] [<commit>...]

    Options:
        --force  Force
        -r       Re-fetch"
        -m MSG   Merge commit message
        -u       Allow unrelated history
HELPUSAGE
}

UNRELATED_HIST=""
MESSAGE=""
TEMP=$(getopt -n release --long force,message:,unrelated,re-fetch -o ufrm: -- "$@")
eval set -- "$TEMP"

while true; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -u | --unrelated )
            UNRELATED_HIST='--allow-unrelated-histories'
            shift;
            ;;
        -m | --message )
            MESSAGE="-m '$2'"
            shift 2;
            ;;
        -r | --re-fetch )
            echo "Re-fetching updates"
            git fetch -q
            shift;
            ;;
        -f | --force)
            echo "WARNING: Force enabled"
            FORCE="--overwrite-ignore"
            shift;
            ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

BRANCH=${@:$OPTIND:1}

if [ -z "$BRANCH" ]; then
    echo "No branch was specified." >&2;
    echo ""
    usage
    exit 0;
fi

git merge --squash $FORCE $UNRELATED_HIST $BRANCH
git commit $MESSAGE
