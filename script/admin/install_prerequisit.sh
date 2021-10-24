#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $REMOTE_CMD_ADMIN apt-get install screen
$REMOTE_CMD_ADMIN apt-get install screen

$REMOTE_CMD_ADMIN bash -c \"ulimit -n 102400\"
$REMOTE_CMD_ADMIN "echo -e \"*        soft    nofile    102400\n*        hard    nofile    1048576\" | sudo tee \"/etc/security/limits.d/99-oasis-node.conf\""


