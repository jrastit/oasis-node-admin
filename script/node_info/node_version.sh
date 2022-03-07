#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

STATUS=`$SCRIPT_NODE_INFO_DIR/status.sh`
echo -e "$STATUS" | jq -r .software_version
echo Paratime
echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .descriptor.deployments'
