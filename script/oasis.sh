#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $NETWORK_BIN -a $NETWORK_ADDR $@ >&2
$NETWORK_BIN -a $NETWORK_ADDR $@

