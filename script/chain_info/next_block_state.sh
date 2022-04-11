#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
$SCRIPT_DIR/oasis.sh consensus next_block_state | jq .prevotes.ratio
