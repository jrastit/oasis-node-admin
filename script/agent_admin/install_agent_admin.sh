#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

log_cmd $REMOTE_CMD "[ -f .ssh/id_rsa.pub ] || ssh-keygen -f .ssh/id_rsa -N \"\""
KEY="$@"
echo SSH Key $KEY
$SCRIPT_DIR/report/run_all.sh "agent_admin/install_ssh_key_admin.sh \"$KEY\""
