#import
#NETWORK_NODE_NAME=testnet
#NETWORK_HOST=oasis@host
#NETWORK_DIR="/home/oasis/testnet"
#NETWORK_BIN_PATH="$NETWORK_DIR/node/bin/oasis-node"
#OASIS_CORE_VERSION="21.2.7"
#OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"
#NETWORK_ADDR="unix:$NETWORK_DIR/node/data/internal.sock"
#NETWORK_CONFIG="$NETWORK_DIR/node/etc/config.yml"
. oasis_custom.sh

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export OASIS_CORE_DIR="oasis_core_${OASIS_CORE_VERSION}_linux_amd64"
export OASIS_CORE_TAR="${OASIS_CORE_DIR}.tar.gz"
export OASIS_CORE_URL="https://github.com/oasisprotocol/oasis-core/releases/download/v${OASIS_CORE_VERSION}/${OASIS_CORE_TAR}"
export OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"

export LOCAL_DIR="$SCRIPT_DIR/.."
export LOCAL_BIN="$LOCAL_DIR/oasis-core/$OASIS_CORE_DIR/oasis-node"
export LOCAL_TX="$LOCAL_DIR/tx"

export ENTITY_DIR="$LOCAL_DIR/entity/"
export GENESIS_JSON="$LOCAL_DIR/genesis.json"

export SSHCMD="ssh -4 $NETWORK_HOST"
export NETWORK_BIN="$SSHCMD $NETWORK_BIN_PATH"
export NETWORK_BIN_SCREEN="$SSHCMD screen -S $NETWORK_NODE_NAME -dm $NETWORK_BIN_PATH"
export NETWORK_SCREEN="$SSHCMD -t screen -r $NETWORK_NODE_NAME"

mkdir -p $LOCAL_TX
