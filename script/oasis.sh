#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $OASIS_NODE_BIN -a $OASIS_NODE_ADDR $@ >&2
$OASIS_NODE_BIN -a $OASIS_NODE_ADDR $@

