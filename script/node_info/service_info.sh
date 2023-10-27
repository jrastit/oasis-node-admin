#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh


$REMOTE_CMD "ls -l /etc/systemd/user"
$REMOTE_CMD "systemctl --user status oasis_$OASIS_NODE_NAME.service"
$REMOTE_CMD "journalctl -q -u oasis_$OASIS_NODE_NAME.service -n 100 --no-pager"
