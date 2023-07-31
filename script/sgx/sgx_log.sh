#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo grep sgx /var/log/syslog
$REMOTE_CMD_ADMIN grep sgx /var/log/syslog


