#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

CMD="bash -c 'cat > /etc/systemd/user/oasis_$OASIS_NODE_NAME.service <<- EOF
[Unit]
Description=Oasis server $OASIS_NODE_NAME
DefaultDependencies=no
After=network.target

[Service]
ExecStart=$OASIS_NODE_DIR/start_node.sh
Type=simple
#User=$OASIS_NODE_SSH_NAME
#Group=$OASIS_NODE_SSH_NAME
Restart=always
KillSignal=SIGINT
SendSIGKILL=no


[Install]
RequiredBy=network.target

EOF'"
echo -e "$CMD"
$REMOTE_CMD_ADMIN "$CMD"
$REMOTE_CMD_ADMIN systemctl daemon-reload