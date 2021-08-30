#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_NODE_INFO_DIR/status.sh | grep -m 1 latest_time | awk '{print substr($2, 2, length($2)-3)}' | xargs date -d
