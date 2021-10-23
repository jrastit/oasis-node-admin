#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $REMOTE_CMD_ADMIN apt-get update
$REMOTE_CMD_ADMIN apt-get update

echo $REMOTE_CMD_ADMIN apt-get dist-upgrade
$REMOTE_CMD_ADMIN apt-get dist-upgrade

echo $REMOTE_CMD_ADMIN apt-get install vim
$REMOTE_CMD_ADMIN apt-get install vim
