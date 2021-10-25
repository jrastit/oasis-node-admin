#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh


$REMOTE_CMD_ADMIN bash -c "partprobe "
$REMOTE_CMD_ADMIN bash -c "lsblk && ls -lrt /dev/disk/by-uuid && cat /etc/fstab"

