#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

#$REMOTE_CMD_ADMIN "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
$REMOTE_CMD_ADMIN "source "/root/.cargo/env""
$REMOTE_CMD_ADMIN cargo install sgxs-tools
