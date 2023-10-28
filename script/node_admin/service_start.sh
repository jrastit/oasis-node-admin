#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD systemctl --user daemon-reload && sudo loginctl enable-linger
$REMOTE_CMD systemctl --user start oasis_$OASIS_NODE_NAME.service


