get_paratime_var() {
    local NODE_TYPE=$1
    case $NODE_TYPE in
	nonvalidator)
		PARATIME_RUNTIME_ORC=""
		PARATIME_RUNTIME_ORC_LINK=""
		PARATIME_RUNTIME_ORC_LINK_OLD=""
		OASIS_NODE_PARATIME=
        OASIS_NODE_REGISTER=$OASIS_NODE_REGISTER	
	;;
	validator)
        PARATIME_RUNTIME_ORC=""
		PARATIME_RUNTIME_ORC_LINK=""
		PARATIME_RUNTIME_ORC_LINK_OLD=""
		OASIS_NODE_PARATIME=
        OASIS_NODE_REGISTER="true"
	;;
	emerald)
		OASIS_NODE_REGISTER="true"
		PARATIME_RUNTIME_ORC="emerald-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK="https://github.com/oasisprotocol/emerald-paratime/releases/download/v$PARATIME_RUNTIME_VERSION/emerald-paratime.orc"
		PARATIME_RUNTIME_ORC_LINK_OLD="https://github.com/oasisprotocol/emerald-paratime/releases/download/v$PARATIME_RUNTIME_VERSION_OLD/emerald-paratime.orc"
		OASIS_NODE_PARATIME="emerald"
	;;
	cipher)
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
		echo "config error type : $NODE_TYPE not found"
	;;
esac

}

load_paratime() {
    local NODE_TYPE=$1
    echo "load_paratime $NODE_TYPE"
    CONFIG_TYPE_DIR=$SCRIPT_DIR/../config/network/$OASIS_NODE_NETWORK/$NODE_TYPE
        . $CONFIG_TYPE_DIR/type_config.sh
        #paratime

if [ -n "$CUSTOM_OASIS_PARATIME_CORE_VERSION" ] ; then 
	OASIS_CORE_VERSION=$CUSTOM_OASIS_PARATIME_CORE_VERSION
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_IDENTIFIER" ] ; then 
	PARATIME_RUNTIME_IDENTIFIER=$CUSTOM_PARATIME_RUNTIME_IDENTIFIER
fi

if [ -n "$CUSTOM_PARATIME_RUNTIME_VERSION" ] ; then 
	PARATIME_RUNTIME_VERSION=$CUSTOM_PARATIME_RUNTIME_VERSION
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

get_paratime_var $NODE_TYPE

if [ -n "$PARATIME_RUNTIME_VERSION" ] ; then 
	PARATIME_RUNTIME_DIR_NAME=$NODE_TYPE
	PARATIME_RUNTIME_DIR=$LOCAL_DIR/paratime/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
	PARATIME_RUNTIME_REMOTE_DIR=$OASIS_NODE_RUNTIME_PATH/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
	if [ -n "$PARATIME_RUNTIME_VERSION_OLD" ] ; then 
		PARATIME_RUNTIME_OLD_REMOTE_DIR=$OASIS_NODE_RUNTIME_PATH/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION_OLD
	fi
fi

}

install_paratime_all() {
    all=($OASIS_NODE_TYPE)
    for NODE_TYPE in "${all[@]}"; do
        echo "install paratime $NODE_TYPE"
        load_paratime $NODE_TYPE        
        install_paratime $NODE_TYPE
    done
}

install_paratime() {
    local NODE_TYPE=$1
    echo $PARATIME_RUNTIME_ORC_LINK
    echo $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC

    $REMOTE_CMD test -d $PARATIME_RUNTIME_REMOTE_DIR
    if [ $? == 1 ]; then
	    echo "install paratime $PARATIME_RUNTIME_VERSION"
	    $REMOTE_CMD mkdir -p $PARATIME_RUNTIME_REMOTE_DIR

	    $REMOTE_CMD wget --quiet -O $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC  $PARATIME_RUNTIME_ORC_LINK
    else
	    echo "already install paratime $PARATIME_RUNTIME_VERSION"
    fi

    echo $PARATIME_RUNTIME_ORC_LINK_OLD
    echo $PARATIME_RUNTIME_OLD_REMOTE_DIR/$PARATIME_RUNTIME_ORC

    $REMOTE_CMD test -d $PARATIME_RUNTIME_OLD_REMOTE_DIR
    if [ $? == 1 ]; then
	    echo "install paratime $PARATIME_RUNTIME_VERSION_OLD"
	    $REMOTE_CMD mkdir -p $PARATIME_RUNTIME_OLD_REMOTE_DIR
	
	    $REMOTE_CMD wget --quiet -O $PARATIME_RUNTIME_OLD_REMOTE_DIR/$PARATIME_RUNTIME_ORC  $PARATIME_RUNTIME_ORC_LINK_OLD
    else
	    echo "already install paratime $PARATIME_RUNTIME_VERSION"
    fi
}