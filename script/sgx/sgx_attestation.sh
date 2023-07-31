#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "Runnin attestation-tool"
$REMOTE_CMD_ADMIN wget https://github.com/oasisprotocol/tools/releases/download/attestation-tool-0.1.0/attestation-tool -O /root/attestation-tool
$REMOTE_CMD_ADMIN chmod +x /root/attestation-tool
$REMOTE_CMD_ADMIN /root/attestation-tool
