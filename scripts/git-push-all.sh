#/bin/bash

DATESTAMP=$(date +%Y%m%d-%H%M%S)

git add .
git commit --allow-empty -am "jufaerma WIP at $(date +%Y%m%d-%H%M%S)"
git push


git commit --allow-empty -am "jufaerma WIP at $(date +%Y%m%d-%H%M%S)" && git push