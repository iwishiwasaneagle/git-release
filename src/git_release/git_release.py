import dataclasses
import re
import argparse as ap
import warnings
import git
import pathlib


def setup_ap() -> ap.ArgumentParser:  # pragma: no cover
    parser = ap.ArgumentParser("git-release")

    # -- SemVer --- #
    semver_behaviour = parser.add_argument_group(
        "Semantic Version",
        description="Options to manipulate the version. If --version is not passed, "
        "git-release uses the most recent tag.",
    )

    semver_behaviour.add_argument(
        "--version",
        type=validate_semver,
        default=get_scm(),
        help="Custom semantic version. Use --no-inc to use as is.",
    )

    increment = semver_behaviour.add_mutually_exclusive_group()

    increment.add_argument(
        "--major",
        "-M",
        dest="inc_major",
        action="store_true",
        help="Increment the major version by 1 (resets minor and patch)",
    )
    increment.add_argument(
        "--minor",
        "-m",
        dest="inc_minor",
        action="store_true",
        help="Increment the minor version by 1 (resets patch)",
    )
    increment.add_argument(
        "--patch",
        "-P",
        default=True,
        action="store_true",
        help="Increment the patch version by 1 (default behaviour)",
        dest="inc_patch",
    )
    increment.add_argument(
        "--no-inc",
        action="store_true",
        help="Don't increment " "anything",
        default=False,
    )

    return parser


def main():  # pragma: no cover
    parser = setup_ap()
    args = parser.parse_args()

    semver = args.version
    print(args)
    if not args.no_inc:
        if args.inc_major:
            semver = increment_major_semver_by_one(semver)
        elif args.inc_minor:
            semver = increment_minor_semver_by_one(semver)
        elif args.inc_patch:
            semver = increment_patch_semver_by_one(semver)
    else:
        warnings.warn(
            f"You have chosen not to increment the semantic version. This "
            f"may cause errors within Git"
        )
    print(semver_dataclass_to_string(semver))


@dataclasses.dataclass
class SemVer:
    major: int
    minor: int
    patch: int

    def __int__(self):
        shift = max([len(bin(f)[2:]) for f in (self.major, self.minor, self.patch)])
        return (self.major << 2 * shift) + (self.minor << shift) + self.patch

    def __eq__(self, other: object):
        if not isinstance(other, SemVer):
            return False
        return int(self) == int(other)

    def __ge__(self, other):
        return int(self) >= int(other)

    def __le__(self, other):
        return int(self) <= int(other)

    def __lt__(self, other):
        return int(self) < int(other)

    def __gt__(self, other):
        return int(self) > int(other)

    def __str__(self):
        return semver_dataclass_to_string(self)


def get_current_repo_version(path: pathlib.Path = None):
    repo = git.Repo(
        path if path is not None else pathlib.Path.cwd(), search_parent_directories=True
    )

    # if repo.is_dirty():
    #     raise Exception("This repo has unstaged changes. Git-release needs to be run in"
    #                     "a up-to-date one in order to be effective. Please stage your"
    #                     "changes and re-run.")

    tags = repo.tags
    semver_list = []
    for tag in tags:
        try:
            semver_list.append(validate_semver(tag.name))
        except Exception:  # TODO Use custom exceptions
            pass

    if len(semver_list) == 0:
        warnings.warn(
            "No valid semver tags were found in this repo. Running with"
            "v0.0.0 and following increment procedure."
        )
        return SemVer(0, 0, 0)
    return max(semver_list)


def validate_semver(tocheck: str) -> SemVer:
    semver_regex = r"^v?(?P<major>\d+)\.(?P<minor>\d+)\.(?P<patch>\d+)$"
    result = re.findall(semver_regex, tocheck)

    if len(result) == 1:
        major, minor, patch = [int(f) for f in result[0]]
        return SemVer(major, minor, patch)
    raise Exception(
        f"Expected a single semver (v<major>.<minor>.<patch>) but got "
        f"{len(result)} instead"
    )


def increment_major_semver_by_one(semver: SemVer):
    semver = increment_semver(semver, major=1)
    semver.minor = 0
    semver.patch = 0
    return semver


def increment_minor_semver_by_one(semver: SemVer):
    semver = increment_semver(semver, minor=1)
    semver.patch = 0
    return semver


def increment_patch_semver_by_one(semver: SemVer):
    return increment_semver(semver, patch=1)


def increment_semver(
    semver: SemVer, major: int = 0, minor: int = 0, patch: int = 0
) -> SemVer:
    semver.major += major
    semver.minor += minor
    semver.patch += patch
    return semver


def semver_dataclass_to_string(semver: SemVer, with_v: bool = True) -> str:
    return f"{'v' if with_v else ''}{semver.major}.{semver.minor}.{semver.patch}"
