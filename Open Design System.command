#!/bin/zsh
set -euo pipefail

cd "$(dirname "$0")"
exec ./bin/serve-design-system
