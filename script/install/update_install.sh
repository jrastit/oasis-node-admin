#/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

all=($OASIS_NODE_TYPE)
$SCRIPT_DIR/config/config_auto.sh
$SCRIPT_DIR/config/config_confirm.sh

. $SCRIPT_DIR/oasis_env.sh
#if [[ "$OASIS_CORE_VERSION" != "22."* ]]; then
#	echo skip because core version is not 22
#	exit 1
#fi

$SCRIPT_DIR/install/install_core.sh
$SCRIPT_DIR/install/install_core_remote.sh
$SCRIPT_DIR/install/install_paratime.sh
$SCRIPT_DIR/node_admin/config_node.sh
