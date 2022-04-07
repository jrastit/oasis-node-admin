#!/bin/bash
SCRIPT_ENTITY_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
$SCRIPT_ENTITY_INFO_DIR/entity_info.sh | awk '/Available\:/{print gensub("\\.", "", "g", $2)}'

sleep 1
