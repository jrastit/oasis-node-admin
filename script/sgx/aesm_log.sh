#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo journalctl -u aesmd.service -b
$REMOTE_CMD_ADMIN journalctl -u aesmd.service -b 


