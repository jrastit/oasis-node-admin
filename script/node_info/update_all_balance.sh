#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

YEAR=2025
ERROR=
# target_dir=$SCRIPT_DIR/../update_balance
mkdir -p $target_dir

#echo "date ; balance" > $SCRIPT_DIR/../report/balance.csv

for month in {1..12}; do
	for day in {01..31}; do
		if date -d "$YEAR-$month-$day" &> /dev/null; then
			timestamp=$(date -d "$YEAR-$month-$day 00:00:00 GMT" +%s)
			echo "Timestamp for $YEAR-$month-$day 00:00 GMT is $timestamp"
			stop_time=$(date -u -d "$YEAR-$month-$day 00:00:10" +"%Y-%m-%dT%H:%M:%SZ")
			start_time=$(date -u -d "$YEAR-$month-$day 00:00:00" +"%Y-%m-%dT%H:%M:%SZ")
			echo "Start time: $start_time" "Stop time: $stop_time"
			response=$(curl -s "https://nexus.oasis.io/v1/consensus/blocks?limit=1&before=$stop_time&after=$start_time")
			if [ $? -ne 0 ]; then
				ERROR="Error fetching data from the API"
				echo $ERROR
				continue
			fi

			block_height=$(echo $response | jq -r '.blocks[0].height')
			block_timestamp=$(echo $response | jq -r '.blocks[0].timestamp')
			if [ "$block_height" == "null" ]; then
				ERROR="Error parsing JSON or no block found"
				echo $ERROR
				continue
			fi
			echo $SCRIPT_DIR/cli_local.sh account show --show-delegations $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK --height $block_height --no-paratime
			UPDATE_BALANCE=`$SCRIPT_DIR/cli_local.sh account show --show-delegations $OASIS_NODE_ENTITY --network $OASIS_NODE_NETWORK --height $block_height --no-paratime`
			# echo -e "$UPDATE_BALANCE"

			TOTAL=$(echo "$UPDATE_BALANCE" | awk '/CONSENSUS/{flag=1;next}/Total/{if(flag){print $2;flag=0}}')
			if [ -z "$TOTAL" ]; then
				ERROR="Total balance not found in the output"
				echo $ERROR
				continue
			fi
			if ! [[ "$TOTAL" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
				ERROR="Total balance is not a valid number: $TOTAL"
				echo $ERROR
				continue
			fi

			echo "Block height: $block_height/ Block timestamp: $block_timestamp / Total balance: $TOTAL"
			# echo -e $UPDATE_BALANCE > $target_dir/${timestamp}_result.txt
			BALANCE=`cut -d ' ' -f 4 <<< $TOTAL | cut -d '.' -f 1`
			DATE2=`date -d @$timestamp +%d/%m/%Y`
			#echo "$DATE2 ; $BALANCE" >> $SCRIPT_DIR/../report/balance.csv
			sleep 0
		fi
	done
done