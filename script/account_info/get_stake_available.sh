#!/bin/bash
SCRIPT_ACCOUNT_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
$SCRIPT_ACCOUNT_INFO_DIR/info.sh | awk '/Available\:/{print gensub("\\.", "", "g", $2)}'

