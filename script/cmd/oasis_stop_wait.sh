#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $SCRIPT_DIR/oasis.sh control shutdown --wait 
$SCRIPT_DIR/oasis.sh control shutdown --wait

