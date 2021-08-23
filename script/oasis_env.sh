export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#import
export NETWORK_NODE_NAME=testnet
export NETWORK_HOST=oasis@host
export NETWORK_DIR="/home/oasis/testnet"
export NETWORK_BIN_PATH="$NETWORK_DIR/node/bin/oasis-node"
export OASIS_CORE_VERSION="21.2.7"
export OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"
export NETWORK_ADDR="unix:$NETWORK_DIR/node/data/internal.sock"
export NETWORK_CONFIG="$NETWORK_DIR/node/etc/config.yml"

. $SCRIPT_DIR/oasis_custom.sh

if [ -z "$CUSTOM_NETWORK_NODE_NAME" ] ; then 
	export NETWORK_NODE_NAME=$CUSTOM_NETWORK_NODE_NAME
fi

if [ -z "$CUSTOM_NETWORK_HOST" ] ; then 
	export NETWORK_HOST=$CUSTOM_NETWORK_HOST;
fi

if [ -z "$CUSTOM_NETWORK_DIR" ] ; then 
	export NETWORK_DIR=$CUSTOM_NETWORK_DIR;
fi

if [ -z "$CUSTOM_NETWORK_BIN_PATH" ] ; then 
	export NETWORK_BIN_PATH=$CUSTOM_NETWORK_BIN_PATH;
fi

if [ -z "$CUSTOM_OASIS_CORE_VERSION" ] ; then 
	export OASIS_CORE_VERSION=$CUSTOM_OASIS_CORE_VERSION
fi

if [ -z "$CUSTOM_OASIS_GENESIS_URL" ] ; then 
	export OASIS_GENESIS_URL=$CUSTOM_OASIS_GENESIS_URL
fi

if [ -z "$CUSTOM_NETWORK_ADDR" ] ; then 
	export NETWORK_ADDR=$NETWORK_ADDR
fi

if [ -z "$CUSTOM_NETWORK_CONFIG" ] ; then 
	export NETWORK_CONFIG=$NETWORK_NETWORK_CONFIG
fi


export OASIS_CORE_DIR="oasis_core_${OASIS_CORE_VERSION}_linux_amd64"
export OASIS_CORE_TAR="${OASIS_CORE_DIR}.tar.gz"
export OASIS_CORE_URL="https://github.com/oasisprotocol/oasis-core/releases/download/v${OASIS_CORE_VERSION}/${OASIS_CORE_TAR}"
export OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"

export LOCAL_DIR="$SCRIPT_DIR/.."
export LOCAL_BIN="$LOCAL_DIR/oasis-core/$OASIS_CORE_DIR/oasis-node"
export LOCAL_TX="$LOCAL_DIR/tx"

export ENTITY_DIR="$LOCAL_DIR/entity"
export GENESIS_JSON="$LOCAL_DIR/genesis.json"
export LOCAL_NODE_DIR=$ENTITY_DIR/node/$NETWORK_NODE_NAME

export SSHCMD="ssh -4 $NETWORK_HOST"
export NETWORK_BIN="$SSHCMD $NETWORK_BIN_PATH"
export NETWORK_BIN_SCREEN="$SSHCMD screen -S $NETWORK_NODE_NAME -dm $NETWORK_BIN_PATH"
export NETWORK_SCREEN="$SSHCMD -t screen -r $NETWORK_NODE_NAME"

mkdir -p $LOCAL_TX
