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
		OASIS_NODE_PARATIME="sapphire"
		;;
	*)
		echo "config error type : $NODE_TYPE not found"
		;;
	esac

}

load_paratime() {
	local NODE_TYPE=$1
	# echo "load_paratime $NODE_TYPE"
	CONFIG_TYPE_DIR=$SCRIPT_DIR/../config/network/$OASIS_NODE_NETWORK/$NODE_TYPE
	. $CONFIG_TYPE_DIR/type_config.sh
	#paratime

	if [ -n "$CUSTOM_OASIS_PARATIME_CORE_VERSION" ]; then
		OASIS_CORE_VERSION=$CUSTOM_OASIS_PARATIME_CORE_VERSION
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_IDENTIFIER" ]; then
		PARATIME_RUNTIME_IDENTIFIER=$CUSTOM_PARATIME_RUNTIME_IDENTIFIER
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_VERSION" ]; then
		PARATIME_RUNTIME_VERSION=$CUSTOM_PARATIME_RUNTIME_VERSION
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_VERSION_OLD" ]; then
		PARATIME_RUNTIME_VERSION_OLD=$CUSTOM_PARATIME_RUNTIME_VERSION_OLD
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_SGSX" ]; then
		PARATIME_RUNTIME_SGSX=$CUSTOM_PARATIME_RUNTIME_SGSX
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_SIG" ]; then
		PARATIME_RUNTIME_SIG=$CUSTOM_PARATIME_RUNTIME_SIG
	fi

	if [ -n "$CUSTOM_PARATIME_RUNTIME_IAS" ]; then
		PARATIME_RUNTIME_IAS=$CUSTOM_PARATIME_RUNTIME_IAS
	fi

	get_paratime_var $NODE_TYPE

	if [ -n "$PARATIME_RUNTIME_VERSION" ]; then
		PARATIME_RUNTIME_DIR_NAME=$NODE_TYPE
		PARATIME_RUNTIME_DIR=$LOCAL_DIR/paratime/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
		PARATIME_RUNTIME_REMOTE_DIR=$OASIS_NODE_RUNTIME_PATH/$PARATIME_RUNTIME_DIR_NAME/$PARATIME_RUNTIME_VERSION
		if [ -n "$PARATIME_RUNTIME_VERSION_OLD" ]; then
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

paratime_version() {
	if [ "$PARATIME_RUNTIME_IDENTIFIER" == "" ]; then
		echo $(echo -e "$STATUS" | jq -r .software_version)
		return
	fi
	MAJOR=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[0].major")
	MINOR=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[0].minor")
	PATCH=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[0].patch")
	MAJOR1=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[1].major")
	MINOR1=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[1].minor")
	PATCH1=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.host.versions[1].patch")
	if [[ ${MAJOR} == 'null' ]]; then
		MAJOR=0
	fi
	if [[ ${MINOR} == 'null' ]]; then
		MINOR=0
	fi
	if [[ ${PATCH} == 'null' ]]; then
		PATCH=0
	fi
	if [[ ${MAJOR1} == 'null' ]]; then
		MAJOR1=0
	fi
	if [[ ${MINOR1} == 'null' ]]; then
		MINOR1=0
	fi
	if [[ ${PATCH1} == 'null' ]]; then
		PATCH1=0
	fi
	if [[ $MAJOR1 -gt $MAJOR ]]; then
		SWITCH=1
	elif [[ $MAJOR1 -eq $MAJOR ]]; then
		if [[ $MINOR1 -gt $MINOR ]]; then
			SWITCH=1
		elif [[ $MINOR1 -eq $MINOR ]]; then
			if [[ $PATCH1 -gt $PATCH ]]; then
				SWITCH=1
			fi
		fi
	fi

	if [[ SWITCH -eq 1 ]]; then
		MAJOR=$MAJOR1
		MINOR=$MINOR1
		PATCH=$PATCH1
	fi
	echo $MAJOR.$MINOR.$PATCH
}

paratime_status() {
	if [ "$PARATIME_RUNTIME_IDENTIFIER" == "" ]; then
		echo $(echo -e "$STATUS" | jq -r .consensus.status)
		return
	fi
	PARATIME_STATUS=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".committee.status")
	PARATIME_STATUS2=$(echo -e "$STATUS" | jq -r ".runtimes.\"$PARATIME_RUNTIME_IDENTIFIER\".executor.status")
	echo $PARATIME_STATUS/$PARATIME_STATUS2
}

paratime_info_all() {
	VERSION=${OASIS_CORE_VERSION}
	PARATIME_RUNTIME_IDENTIFIER=""
	PARATIME_STATUS_RUNTIME=$(paratime_status)
	RUNTIME_VERSION=$(paratime_version $PARATIME_RUNTIME_IDENTIFIER)
	INFO="$RUNTIME_VERSION"
	if [[ ${VERSION} != ${RUNTIME_VERSION}* ]]; then
		ERROR="$ERROR $(echo core version error ${RUNTIME_VERSION}/${VERSION})\n"
	fi
	all=($OASIS_NODE_TYPE)
	for NODE_TYPE in "${all[@]}"; do
		load_paratime $NODE_TYPE
		if [ "$PARATIME_RUNTIME_IDENTIFIER" == "" ]; then
			INFO="$INFO $NODE_TYPE"
		else
			VERSION=$PARATIME_RUNTIME_VERSION
			RUNTIME_VERSION=$(paratime_version $PARATIME_RUNTIME_IDENTIFIER)
			if [[ ${VERSION} != ${RUNTIME_VERSION}* ]]; then
				ERROR="$ERROR $(echo $NODE_TYPE version error ${RUNTIME_VERSION}/${VERSION})\n"
			fi
			PARATIME_STATUS_RUNTIME=$(paratime_status)
			if [[ $PARATIME_STATUS_RUNTIME != 'ready' && $PARATIME_STATUS_RUNTIME != 'ready/ready' ]]; then
				ERROR="$ERROR $(echo $NODE_TYPE status error $PARATIME_STATUS_RUNTIME)\n"
			fi
			INFO="$INFO $NODE_TYPE $RUNTIME_VERSION"
		fi
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

		$REMOTE_CMD wget --quiet -O $PARATIME_RUNTIME_REMOTE_DIR/$PARATIME_RUNTIME_ORC $PARATIME_RUNTIME_ORC_LINK
	else
		echo "already install paratime $PARATIME_RUNTIME_VERSION"
	fi

	echo $PARATIME_RUNTIME_ORC_LINK_OLD
	echo $PARATIME_RUNTIME_OLD_REMOTE_DIR/$PARATIME_RUNTIME_ORC

	$REMOTE_CMD test -d $PARATIME_RUNTIME_OLD_REMOTE_DIR
	if [ $? == 1 ]; then
		echo "install paratime $PARATIME_RUNTIME_VERSION_OLD"
		$REMOTE_CMD mkdir -p $PARATIME_RUNTIME_OLD_REMOTE_DIR

		$REMOTE_CMD wget --quiet -O $PARATIME_RUNTIME_OLD_REMOTE_DIR/$PARATIME_RUNTIME_ORC $PARATIME_RUNTIME_ORC_LINK_OLD
	else
		echo "already install paratime $PARATIME_RUNTIME_VERSION"
	fi
}
