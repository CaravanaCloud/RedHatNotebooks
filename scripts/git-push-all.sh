#/bin/bash

DATESTAMP=$(date +%Y%m%d-%H%M%S)

git commit --allow-empty -am "$(whoami) WIP at $(date +%Y%m%d-%H%M%S)"
git push


