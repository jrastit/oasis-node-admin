#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

ls $SCRIPT_DIR/../config/node
echo enter node name
read OASIS_NODE_NAME
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h>$OASIS_NODE_NAME\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export OASIS_NODE_NAME=$OASIS_NODE_NAME
