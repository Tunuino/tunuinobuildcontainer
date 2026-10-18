#!/usr/bin/env bash
set -euo pipefail
# Same bind-mounted source layout and disposable container lifecycle as rusEFI.
cd "$(dirname "$0")"
mkdir -p repo
docker run --rm -it -v "$(pwd)/repo:/tunuino" --name tunuino_build tunuino_build:0.3 "$@"
