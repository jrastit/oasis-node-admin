#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo service aesmd status
# $REMOTE_CMD_ADMIN docker exec -i aesmd bash
$REMOTE_CMD_ADMIN service aesmd status
