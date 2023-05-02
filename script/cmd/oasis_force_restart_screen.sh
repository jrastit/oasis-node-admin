#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/cmd/oasis_force_stop.sh
sleep 1
$SCRIPT_DIR/cmd/oasis_start_screen.sh
