#!/bin/bash
REPORT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" &> /dev/null && pwd )"

echo $REPORT_SCRIPT_DIR

cd $REPORT_SCRIPT_DIR

. $REPORT_SCRIPT_DIR/../set_node.sh testnet

REPORT_DIR=$REPORT_SCRIPT_DIR/../../report

REPORT_FILE=$REPORT_DIR/report.txt
REPORT_ERROR=$REPORT_DIR/report_error.txt
REPORT_TMP=$REPORT_DIR/tmp1.txt
REPORT_TMP_OLD=$REPORT_DIR/tmp2.txt

mkdir -p /tmp/oasis/ $REPORT_DIR
cp $REPORT_TMP $REPORT_TMP_OLD
$REPORT_SCRIPT_DIR/report_all.sh ./node_info/check_status.sh > $REPORT_TMP
#cat $REPORT_TMP

DIFF=$(diff -u $REPORT_TMP $REPORT_TMP_OLD)
if [ "$DIFF" != "" ] 
then
	touch $REPORT_ERROR
	REPORT_ERROR_OLD=`cat $REPORT_ERROR`
	echo "Status has change"
	echo -e "`date`\n$DIFF\n\n\n$REPORT_ERROR_OLD\n" > $REPORT_ERROR
	$REPORT_SCRIPT_DIR/../api/ifttt.sh    	
fi

date > $REPORT_DIR/report.txt
echo >> $REPORT_DIR/report.txt
cat $REPORT_TMP >> $REPORT_DIR/report.txt






