#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

$SCRIPT_DIR/node_admin/service_stop.sh
$SCRIPT_DIR/node_admin/clean_log.sh
$SCRIPT_DIR/node_admin/service_start.sh


