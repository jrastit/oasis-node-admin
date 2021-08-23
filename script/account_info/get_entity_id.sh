#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh
cat $ENTITY_DIR/entity.json | awk 'BEGIN { FS = "\"" } ;{print($6)}' 

