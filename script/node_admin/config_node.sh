#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ "$OASIS_CORE_VERSION" == "22."* ]]; then
	case $OASIS_NODE_TYPE in
		validator)
			echo "config validator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_validator.sh
		;;
		nonvalidator)
			echo "config nonvalidator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_nonvalidator.sh
		;;
		validator_emerald)
			echo "config validator with emerald"
			$SCRIPT_NODE_ADMIN_DIR/config_node_validator_paratime.sh
		;;
		emerald)
			echo "config emerald"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		cipher-paratime)
			echo "config cipher"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		sapphire)
			echo "config sapphire"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		*)
			echo "config error type : $OASIS_NODE_TYPE not found"
		;;
	esac
else
	echo "config error type : $OASIS_CORE_VERSION not supported"
fi

