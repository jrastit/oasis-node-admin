#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $REMOTE_DIR/cron/update_balance 
$REMOTE_CMD ls -la $REMOTE_DIR/cron/update_balance 

