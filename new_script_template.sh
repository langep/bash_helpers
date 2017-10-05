#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Inspired by https://dev.to/thiht/shell-scripts-matter 

#/ Usage:
#/ Description:
#/ Examples:
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

# Locate this script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import helper functions.
source utils.sh

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    # ...
fi