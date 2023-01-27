#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $REMOTE_DIR/cron/update_balance $SCRIPT_DIR/../
$REMOTE_SYNC -t $REMOTE_DIR/cron/update_balance $SCRIPT_DIR/../



echo "date ; balance" > $SCRIPT_DIR/../report/balance.csv
LAST_BALANCE=0
for f in `ls $SCRIPT_DIR/../update_balance/*_result.txt | sort -n`; do
	#echo $f
	TIMESTAMP=`cut -d_ -f 1 <<< "$(basename $f)"`
	DATE=`date -d @$TIMESTAMP +%Y/%m/%d`
	DATE2=`date -d @$TIMESTAMP +%m/%d/%Y`
	TOTAL=`grep Total $f | head -n 1`
	BALANCE=`cut -d ' ' -f 4 <<< $TOTAL | cut -d '.' -f 1`
	if [[ -z $BALANCE ]] ; then
		echo -e "$DATE2\tEmpty"
		echo "$DATE2 ; $LAST_BALANCE" >> $SCRIPT_DIR/../report/balance.csv
	else
		DIFF=$(($BALANCE - $LAST_BALANCE))
		LAST_BALANCE=$BALANCE
		echo -e "$DATE2\t$BALANCE\t$DIFF"
		echo "$DATE2 ; $BALANCE" >> $SCRIPT_DIR/../report/balance.csv
	fi
done

