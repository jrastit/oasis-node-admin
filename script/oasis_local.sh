#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
CMDOASIS="$LOCAL_BIN $@"

echo $CMDOASIS >&2
$CMDOASIS

