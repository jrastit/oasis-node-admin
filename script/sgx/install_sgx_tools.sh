#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

# $REMOTE_CMD_ADMIN "apt-get install gcc protobuf-compiler pkg-config libssl-dev"
# $REMOTE_CMD_ADMIN "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
# $REMOTE_CMD_ADMIN "mv .cargo /root/.cargo"
$REMOTE_CMD_ADMIN "echo $HOME"
$REMOTE_CMD_ADMIN bash -c "cargo install sgxs-tools"
