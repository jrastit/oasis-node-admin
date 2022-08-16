#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/cmd/oasis_stop_wait.sh
$SCRIPT_DIR/cmd/oasis_start_screen.sh

