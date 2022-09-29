#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

log_cmd $REMOTE_SYNC $ENTITY_DIR/entity.json $REMOTE_DIR/node/entity/entity.json
