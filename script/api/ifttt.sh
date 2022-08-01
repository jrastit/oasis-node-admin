#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

if [[ -f $CONFIG_API_DIR/ifttt-key.sh ]] ; then
	IFTTT_KEY=`$CONFIG_API_DIR/ifttt-key.sh`
	IFTTT_EVENT='oasisupdate'
	IFTTT_URL="https://maker.ifttt.com/trigger/$IFTTT_EVENT/with/key/$IFTTT_KEY"
	#curl -X POST -H "Content-Type: application/json" -d '{"value1":"test"}' https://maker.ifttt.com/trigger/notify/with/key/123jhkjh3k4h24j343
	curl -X POST -H "Content-Type: application/json" $IFTTT_URL 
else
	echo "IFTTT key not set in $CONFIG_API_DIR/ifttt-key.sh"
fi


