#!/bin/bash
REPORT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" &> /dev/null && pwd )"

echo "date ; balance" > $REPORT_SCRIPT_DIR/../../report/balance.csv
LAST_BALANCE=0
for f in `ls $REPORT_SCRIPT_DIR/../../update_balance/*_result.txt | sort -n`; do
	#echo $f
	TIMESTAMP=`cut -d_ -f 1 <<< "$(basename $f)"`
	DATE=`date -d @$TIMESTAMP +%Y/%m/%d`
	DATE2=`date -d @$TIMESTAMP +%m/%d/%Y`
	TOTAL=`grep Total $f | head -n 1`
	BALANCE=`cut -d ' ' -f 4 <<< $TOTAL | cut -d '.' -f 1`
	DIFF=$(($BALANCE - $LAST_BALANCE))
	LAST_BALANCE=$BALANCE
	echo -e "$DATE2\t$BALANCE\t$DIFF"
	echo "$DATE2 ; $BALANCE" >> $REPORT_SCRIPT_DIR/../../report/balance.csv
done

