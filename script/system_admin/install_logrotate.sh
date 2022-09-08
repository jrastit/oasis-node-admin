#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD_ADMIN apt install logrotate
$REMOTE_CMD_ADMIN mkdir -p $OASIS_NODE_LOG_PATH
$REMOTE_CMD_ADMIN chown $OASIS_NODE_SSH_NAME.$OASIS_NODE_SSH_NAME $OASIS_NODE_LOG_PATH

$REMOTE_CMD_ADMIN "echo -e \"$OASIS_NODE_LOG_FILE {\n  rotate 7\n  daily  \n  compress\n  delaycompress\n  missingok\n  notifempty\n  create 644 $OASIS_NODE_SSH_NAME $OASIS_NODE_SSH_NAME\n}\" | sudo tee /etc/logrotate.d/oasis_$OASIS_NODE_NAME" 
