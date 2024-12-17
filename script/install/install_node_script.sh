#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$REMOTE_CMD "cat > $OASIS_NODE_DIR/start_node.sh <<- EOF
#!/bin/bash
if [ -f "$OASIS_NODE_DIR/service_disable" ]; then
    echo "Service is disabled. Exiting."
    exit 0
fi
$OASIS_NODE_BIN_PATH/$OASIS_CORE_DIR/oasis-node --config $OASIS_NODE_CONFIG

EOF"

$REMOTE_CMD "chmod +x $OASIS_NODE_DIR/start_node.sh"
echo "Node start script created at $OASIS_NODE_DIR/start_node.sh with $OASIS_CORE_DIR"

