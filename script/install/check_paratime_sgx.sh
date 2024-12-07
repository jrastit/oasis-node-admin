#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo check isgx device
ls -l /dev/isgx

echo nmap $OASIS_NODE_ADDR -p $OASIS_NODE_PORT,$CUSTOM_OASIS_P2P_PORT -Pn
nmap $OASIS_NODE_ADDR -p $OASIS_NODE_PORT,$CUSTOM_OASIS_P2P_PORT -Pn
