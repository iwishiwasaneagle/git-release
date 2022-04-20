# Git Smash

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/iwishiwasaneagle/git-release/master.svg)](https://results.pre-commit.ci/latest/github/iwishiwasaneagle/git-release/master)
[![CI](https://github.com/iwishiwasaneagle/git-release/actions/workflows/CI.yml/badge.svg)](https://github.com/iwishiwasaneagle/git-release/actions/workflows/CI.yml)
[![License](https://img.shields.io/github/license/iwishiwasaneagle/git-release)](https://github.com/iwishiwasaneagle/git-release/blob/master/LICENSE.txt)

Easily **SMASH** your commits into another branch.

## Installation

```bash
sudo make install
```

## Example

We have our branch `example` with `example.txt` and wish to quickly squash merge with a message. Easy!

```bash
$ git diff master example
diff --git a/example.txt b/example.txt
new file mode 100644
index 0000000..9606a0c
--- /dev/null
+++ b/example.txt
@@ -0,0 +1 @@
+Gentwemen, a showt view back to the past. Thiwty yeaws ago, Niki Wauda towd us ‘take a monkey, pwace him into the cockpit and he is abwe to dwive the caw.’ Thiwty yeaws watew, Sebastian towd us ‘I had to stawt my caw wike a computew, it’s vewy compwicated.’ And Nico Wosbewg said that duwing the wace – I don’t wemembew what wace - he pwessed the wwong button on the wheew. Question fow you both: is Fowmuwa One dwiving today too compwicated with twenty and mowe buttons on the wheew, awe you too much undew effowt, undew pwessuwe? What awe youw wishes fow the futuwe concewning the technicaw pwogwamme duwing the wace? Wess buttons, mowe? Ow wess and mowe communication with youw engineews?
\ No newline at end of file

$ git release -ur -m "um" --force example

Re-fetching updates
WARNING: Force enabled
Updating 9a6aa56..1888cd5
Fast-forward
Squash commit -- not updating HEAD
 example.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 example.txt
[master eecb6b0] 'um'
 1 file changed, 1 insertion(+)
 create mode 100644 example.txt
```

## Why?

Bit of craic
