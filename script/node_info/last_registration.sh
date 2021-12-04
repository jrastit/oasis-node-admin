#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_NODE_INFO_DIR/status.sh | jq -r .registration.last_registration 2>/dev/null | xargs date -d 2>/dev/null 
