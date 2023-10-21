#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ "$OASIS_CORE_VERSION" == "22."* ]]; then
	case $OASIS_NODE_TYPE in
		*emerald*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		*cipher*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		*sapphire*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime.sh
		;;
		validator)
			echo "config validator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_validator.sh
		;;
		nonvalidator)
			echo "config nonvalidator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_nonvalidator.sh
		;;
		*)
			echo "config error type : $OASIS_NODE_TYPE not found"
		;;
	esac
elif [[ "$OASIS_CORE_VERSION" == "23."* ]]; then
	case $OASIS_NODE_TYPE in
		*emerald*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime_23.sh
		;;
		*cipher*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime_23.sh
		;;
		*sapphire*)
			echo "config paratime"
			$SCRIPT_NODE_ADMIN_DIR/config_node_paratime_23.sh
		;;
		validator)
			echo "config validator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_validator_23.sh
		;;
		nonvalidator)
			echo "config nonvalidator"
			$SCRIPT_NODE_ADMIN_DIR/config_node_nonvalidator_23.sh
		;;
		*)
			echo "config error type : $OASIS_NODE_TYPE not found"
		;;
	esac
else
	echo "config error type : $OASIS_CORE_VERSION not supported"
fi