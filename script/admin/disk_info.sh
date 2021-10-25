#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh


$REMOTE_CMD_ADMIN lsblk
$REMOTE_CMD_ADMIN ls -lrt /dev/disk/by-uuid
$REMOTE_CMD_ADMIN cat /etc/fstab

