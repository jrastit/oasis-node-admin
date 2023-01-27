SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

config_value () {
	echo "$1 ($2)"
	read READ_VALUE
	if [ -n "$READ_VALUE" ] ; then 
		CONFIG_VALUE="$READ_VALUE"
	else
		CONFIG_VALUE="$2"
	fi

}

log_cmd () {
	echo "$@"
	$@
}

download_file () {
	wget -q -O $1 $2
	if [ $? -ne 0 ]; then
		echo Error: url not found $PARATIME_RUNTIME_EMERALD
		exit 1
	fi 
}

paratime_version () {
  	MAJOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[0].major'`
  	MINOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[0].minor'`
  	PATCH=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[0].patch'`
  	MAJOR1=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[1].major'`
  	MINOR1=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[1].minor'`
  	PATCH1=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee.host.versions[1].patch'`
	if [[ ${MAJOR} == 'null' ]] ; then
    		MAJOR=0
  	fi
  	if [[ ${MINOR} == 'null' ]] ; then
    		MINOR=0
  	fi
  	if [[ ${PATCH} == 'null' ]] ; then
    		PATCH=0
  	fi
	if [[ ${MAJOR1} == 'null' ]] ; then
    		MAJOR1=0
  	fi
  	if [[ ${MINOR1} == 'null' ]] ; then
    		MINOR1=0
  	fi
  	if [[ ${PATCH1} == 'null' ]] ; then
    		PATCH1=0
  	fi
	if [[ $MAJOR1 -gt $MAJOR ]] ; then
		SWITCH=1
	elif [[ $MAJOR1 -eq $MAJOR ]] ; then
		if [[ $MINOR1 -gt $MINOR ]] ; then
			SWITCH=1
		elif [[ $MINOR1 -eq $MINOR ]] ; then
			if [[ $PATCH1 -gt $PATCH ]] ; then
				SWITCH=1
			fi
		fi
	fi

	if [[ SWITCH -eq 1 ]] ; then
		MAJOR=$MAJOR1
		MINOR=$MINOR1
		PATCH=$PATCH1
	fi
  	echo $MAJOR.$MINOR.$PATCH
}

if [ -z "$OASIS_NODE_NAME" ] ; then 
	OASIS_NODE_NAME=oasis_node
fi

LOCAL_DIR="$SCRIPT_DIR/.."

#import
OASIS_NODE_NETWORK="testnet"
OASIS_NODE_TYPE="validator"

OASIS_NODE_ADDR="localhost"
OASIS_NODE_ROOT_DIR="/home/oasis"
OASIS_NODE_SSH_NAME=oasis
OASIS_NODE_SSH_ADMIN_NAME=oasis
OASIS_NODE_PORT=26656
OASIS_NODE_LISTEN_ADDR=0.0.0.0


OASIS_CORE_VERSION="21.3.3"
OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"
OASIS_SEED_NODE="05EAC99BB37F6DAAD4B13386FF5E087ACBDDC450@34.86.165.6:26656"

PARATIME_WORKER_CLIENT_PORT=30001
PARATIME_WORKER_P2P_PORT=30002

LATEST_TIME_ERROR=3600

CONFIG_API_DIR=$SCRIPT_DIR/../config/api

CONFIG_NODE_DIR=$SCRIPT_DIR/../config/node/$OASIS_NODE_NAME
. $CONFIG_NODE_DIR/node_config.sh

if [ -n "$CUSTOM_OASIS_NODE_NETWORK" ] ; then 
	OASIS_NODE_NETWORK=$CUSTOM_OASIS_NODE_NETWORK
fi

if [ -n "$CUSTOM_OASIS_NODE_ENTITY" ] ; then 
	OASIS_NODE_ENTITY=$CUSTOM_OASIS_NODE_ENTITY
fi

if [ -n "$CUSTOM_OASIS_NODE_TYPE" ] ; then 
	OASIS_NODE_TYPE=$CUSTOM_OASIS_NODE_TYPE
fi

CONFIG_ENTITY_DIR=$SCRIPT_DIR/../config/entity/$OASIS_NODE_NETWORK

CONFIG_NETWORK_DIR=$SCRIPT_DIR/../config/network/$OASIS_NODE_NETWORK
. $CONFIG_NETWORK_DIR/network_config.sh

CONFIG_TYPE_DIR=$SCRIPT_DIR/../config/network/$OASIS_NODE_NETWORK/$OASIS_NODE_TYPE
. $CONFIG_TYPE_DIR/type_config.sh

if [ -n "$CUSTOM_OASIS_NODE_ROOT_DIR" ] ; then 
	OASIS_NODE_ROOT_DIR=$CUSTOM_OASIS_NODE_ROOT_DIR
fi

OASIS_NODE_DIR="$OASIS_NODE_ROOT_DIR/$OASIS_NODE_NAME"

if [ -n "$CUSTOM_OASIS_NODE_SSH" ] ; then 
	OASIS_NODE_SSH=$CUSTOM_OASIS_NODE_SSH
fi

if [ -n "$CUSTOM_OASIS_NODE_SSH_ADMIN" ] ; then 
	OASIS_NODE_SSH_ADMIN=$CUSTOM_OASIS_NODE_SSH_ADMIN
fi

if [ -n "$CUSTOM_OASIS_NODE_DIR" ] ; then 
	OASIS_NODE_DIR=$CUSTOM_OASIS_NODE_DIR;
fi

OASIS_NODE_BIN_PATH="$OASIS_NODE_DIR/oasis-core"
OASIS_NODE_RUNTIME_PATH="$OASIS_NODE_DIR/runtimes"
OASIS_NODE_LOG_PATH="$OASIS_NODE_DIR/log"
OASIS_NODE_LOG_FILE="$OASIS_NODE_LOG_PATH/oasis.log"
OASIS_NODE_TX="$OASIS_NODE_DIR/tx"
OASIS_NODE_SOCK="unix:$OASIS_NODE_DIR/node/data/internal.sock"
OASIS_NODE_CONFIG="$OASIS_NODE_DIR/node/etc/config.yml"
OASIS_NODE_GENESIS="$OASIS_NODE_DIR/node/etc/genesis.json"

if [ -n "$CUSTOM_OASIS_NODE_BIN_PATH" ] ; then 
	OASIS_NODE_BIN_PATH=$CUSTOM_OASIS_NODE_BIN_PATH;
fi

if [ -n "$CUSTOM_OASIS_NODE_TX" ] ; then 
	OASIS_NODE_TX=$CUSTOM_OASIS_NODE_TX;
fi

if [ -n "$CUSTOM_OASIS_NODE_PORT" ] ; then 
	OASIS_NODE_PORT=$CUSTOM_OASIS_NODE_PORT
fi

if [ -n "$CUSTOM_OASIS_NODE_LISTEN_ADDR" ] ; then 
	OASIS_NODE_LISTEN_ADDR=$CUSTOM_OASIS_NODE_LISTEN_ADDR
fi

if [ -n "$CUSTOM_OASIS_NODE_CONFIG" ] ; then 
	OASIS_NODE_CONFIG=$CUSTOM_OASIS_NODE_CONFIG
fi

if [ -n "$CUSTOM_OASIS_NODE_GENESIS" ] ; then 
	OASIS_NODE_GENESIS=$CUSTOM_OASIS_NODE_GENESIS
fi

if [ -n "$CUSTOM_OASIS_NODE_ADDR" ] ; then 
	OASIS_NODE_ADDR=$CUSTOM_OASIS_NODE_ADDR
fi

if [ -n "$CUSTOM_OASIS_NODE_SSH_NAME" ] ; then 
	OASIS_NODE_SSH_NAME=$CUSTOM_OASIS_NODE_SSH_NAME
fi

if [ -n "$CUSTOM_OASIS_NODE_SSH_ADMIN_NAME" ] ; then 
	OASIS_NODE_SSH_ADMIN_NAME=$CUSTOM_OASIS_NODE_SSH_ADMIN_NAME
fi

if [ -n "$CUSTOM_OASIS_NODE_SSH_ID" ] ; then 
	OASIS_NODE_SSH_ID=$CUSTOM_OASIS_NODE_SSH_ID
fi

if [ -n "$CUSTOM_LATEST_TIME_ERROR" ] ; then 
	LATEST_TIME_ERROR=$CUSTOM_OASIS_LATEST_TIME_ERROR
fi

#core
if [ -n "$CUSTOM_OASIS_CORE_VERSION" ] ; then 
	OASIS_CORE_VERSION=$CUSTOM_OASIS_CORE_VERSION
fi

if [ -n "$CUSTOM_OASIS_GENESIS_URL" ] ; then 
	OASIS_GENESIS_URL=$CUSTOM_OASIS_GENESIS_URL
fi

if [ -n "$CUSTOM_OASIS_SEED_NODE" ] ; then 
	OASIS_SEED_NODE=$CUSTOM_OASIS_SEED_NODE
fi

#paratime

if [ -n "$CUSTOM_OASIS_PARATIME_CORE_VERSION" ] ; then 
	OASIS_CORE_VERSION=$CUSTOM_OASIS_PARATIME_CORE_VERSION
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_IDENTIFIER" ] ; then 
	PARATIME_RUNTIME_IDENTIFIER=$CUSTOM_PARATIME_RUNTIME_IDENTIFIER
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_VERSION" ] ; then 
	PARATIME_RUNTIME_VERSION=$CUSTOM_PARATIME_RUNTIME_VERSION
	PARATIME_RUNTIME_SGSX="https://github.com/oasisprotocol/cipher-paratime/releases/download/v$CUSTOM_PARATIME_RUNTIME_VERSION/cipher-paratime.sgxs"
	PARATIME_RUNTIME_SIG="https://github.com/oasisprotocol/cipher-paratime/releases/download/v$CUSTOM_PARATIME_RUNTIME_VERSION/cipher-paratime.sig"
	PARATIME_RUNTIME_EMERALD="https://github.com/oasisprotocol/emerald-paratime/releases/download/v$CUSTOM_PARATIME_RUNTIME_VERSION/emerald-paratime"
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_VERSION_OLD" ] ; then
	PARATIME_RUNTIME_VERSION_OLD=$CUSTOM_PARATIME_RUNTIME_VERSION_OLD
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_SGSX" ] ; then 
	PARATIME_RUNTIME_SGSX=$CUSTOM_PARATIME_RUNTIME_SGSX
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_SIG" ] ; then 
	PARATIME_RUNTIME_SIG=$CUSTOM_PARATIME_RUNTIME_SIG
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_IAS" ] ; then 
	PARATIME_RUNTIME_IAS=$CUSTOM_PARATIME_RUNTIME_IAS
fi

if [ -n "$CUSTOM_PARATIME_WORKER_CLIENT_PORT" ] ; then 
	PARATIME_WORKER_CLIENT_PORT=$CUSTOM_PARATIME_WORKER_CLIENT_PORT
fi

if [ -n "$CUSTOM_PARATIME_WORKER_P2P_PORT" ] ; then 
	PARATIME_WORKER_P2P_PORT=$CUSTOM_PARATIME_WORKER_P2P_PORT
fi


OASIS_CORE_DIR="oasis_core_${OASIS_CORE_VERSION}_linux_amd64"
OASIS_CORE_TAR="${OASIS_CORE_DIR}.tar.gz"
OASIS_CORE_URL="https://github.com/oasisprotocol/oasis-core/releases/download/v${OASIS_CORE_VERSION}/${OASIS_CORE_TAR}"


LOCAL_BIN="$LOCAL_DIR/oasis-core/$OASIS_CORE_DIR/oasis-node"
LOCAL_TX="$LOCAL_DIR/tx"

ENTITY_DIR=$CONFIG_ENTITY_DIR/$OASIS_NODE_ENTITY
GENESIS_JSON="$CONFIG_TYPE_DIR/genesis.json"
LOCAL_NODE_DIR="$CONFIG_NODE_DIR/node"

OASIS_NODE_SSH=$OASIS_NODE_SSH_NAME@$OASIS_NODE_ADDR
OASIS_NODE_SSH_ADMIN=$OASIS_NODE_SSH_ADMIN_NAME@$OASIS_NODE_ADDR

SSHCMD="ssh -4 -o StrictHostKeyChecking=accept-new $OASIS_NODE_SSH"
OASIS_NODE_BIN="$SSHCMD $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node"
OASIS_NODE_CLI="$SSHCMD $OASIS_NODE_DIR/cli/cli"
OASIS_NODE_BIN_SCREEN="$SSHCMD screen -S $OASIS_NODE_NAME -dm $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node"
OASIS_NODE_SCREEN="$SSHCMD -t screen -r $OASIS_NODE_NAME"
OASIS_NODE_RESTART_SCREEN="$SSHCMD screen -S restart_$OASIS_NODE_NAME -dm \"$OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node control -a $OASIS_NODE_SOCK shutdown --wait;sleep 10;screen -S $OASIS_NODE_NAME -dm $OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node\""



SCRIPT_ENTITY_INFO_DIR="$SCRIPT_DIR/entity_info"
SCRIPT_ENTITY_ADMIN_DIR="$SCRIPT_DIR/entity_admin"
SCRIPT_NODE_INFO_DIR="$SCRIPT_DIR/node_info"
SCRIPT_NODE_ADMIN_DIR="$SCRIPT_DIR/node_admin"

if [ -n "$OASIS_NODE_SSH" ]; then
	REMOTE_CMD="ssh -4 -o StrictHostKeyChecking=accept-new $OASIS_NODE_SSH"
	REMOTE_CP="scp -4 "
	REMOTE_SYNC="rsync -pvr"
	REMOTE_DIR="$OASIS_NODE_SSH:$OASIS_NODE_DIR"
else 
	REMOTE_CMD=""
	REMOTE_CP="cp"
	REMOTE_SYNC="rsync -vr"
	REMOTE_DIR="$OASIS_NODE_DIR"
fi

if [ -n "$OASIS_NODE_SSH_ADMIN" ]; then
	REMOTE_CMD_ADMIN="ssh -o LogLevel=QUIET -t -4 $OASIS_NODE_SSH_ADMIN sudo"
else 
	REMOTE_CMD_ADMIN="sudo"
fi

OASIS_NODE_REGISTER="false"
case $OASIS_NODE_TYPE in
	nonvalidator)
			
	;;
	validator)	
		OASIS_NODE_REGISTER="true"
	;;
	emerald)
		OASIS_NODE_REGISTER="true"
		PARATIME_RUNTIME_ORC="emerald-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK="https://github.com/oasisprotocol/emerald-paratime/releases/download/v$PARATIME_RUNTIME_VERSION/emerald-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK_OLD="https://github.com/oasisprotocol/emerald-paratime/releases/download/v$PARATIME_RUNTIME_VERSION_OLD/emerald-paratime.orc"
		OASIS_NODE_PARATIME="emerald"
	;;
	cipher-paratime)
		OASIS_NODE_REGISTER="true"
		PARATIME_RUNTIME_ORC="cipher-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK="https://github.com/oasisprotocol/cipher-paratime/releases/download/v$PARATIME_RUNTIME_VERSION/cipher-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK_OLD="https://github.com/oasisprotocol/cipher-paratime/releases/download/v$PARATIME_RUNTIME_VERSION_OLD/cipher-paratime.orc"
		OASIS_NODE_PARATIME="cipher"
	;;
	sapphire)
		OASIS_NODE_REGISTER="true"
		PARATIME_RUNTIME_ORC="sapphire-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK="https://github.com/oasisprotocol/sapphire-paratime/releases/download/v$PARATIME_RUNTIME_VERSION/sapphire-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK_OLD="https://github.com/oasisprotocol/sapphire-paratime/releases/download/v$PARATIME_RUNTIME_VERSION_OLD/sapphire-paratime.orc"
		OASIS_NODE_PARATIME="cipher"
	;;
	*)
		echo "config error type : $OASIS_NODE_TYPE not found"
	;;
esac

if [ -n "$PARATIME_RUNTIME_VERSION" ] ; then 
	PARATIME_RUNTIME_DIR_NAME=$OASIS_NODE_TYPE
	PARATIME_RUNTIME_DIR=$LOCAL_DIR/paratime/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
	PARATIME_RUNTIME_REMOTE_DIR=$OASIS_NODE_RUNTIME_PATH/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
	if [ -n "$PARATIME_RUNTIME_VERSION_OLD" ] ; then 
		PARATIME_RUNTIME_OLD_REMOTE_DIR=$OASIS_NODE_RUNTIME_PATH/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION_OLD
	fi
fi

OASIS_AGENT_DIR="$OASIS_NODE_ROOT_DIR/agent"
GIT_URL="https://github.com/jrastit/oasis-node-admin.git"

mkdir -p $LOCAL_TX
