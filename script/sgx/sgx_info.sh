#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

# echo cat /etc/modprobe.d/blacklist-intel_sgx.conf
# $REMOTE_CMD_ADMIN cat /etc/modprobe.d/blacklist-intel_sgx.conf

# echo cat /etc/modprobe.d/fortanix-isgx.conf
# $REMOTE_CMD_ADMIN cat /etc/modprobe.d/fortanix-isgx.conf

# echo ls -l /dev/sgx /dev/isgx
# $REMOTE_CMD_ADMIN ls -l /dev/sgx /dev/isgx


echo ls -l /dev/sgx
$REMOTE_CMD_ADMIN ls -l /dev/sgx

$REMOTE_CMD_ADMIN "grep \\\"pccs_url\\\" /etc/sgx_default_qcnl.conf"
