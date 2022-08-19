#/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/node_admin/create_node.sh
$SCRIPT_DIR/install/install_genesis_remote.sh
$SCRIPT_DIR/install/update_install.sh

