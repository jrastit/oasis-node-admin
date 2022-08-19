#!/bin/bash
REPORT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" &> /dev/null && pwd )"

echo $REPORT_SCRIPT_DIR

cd $REPORT_SCRIPT_DIR

. $REPORT_SCRIPT_DIR/../set_node.sh mainnet

REPORT_DIR=$REPORT_SCRIPT_DIR/../../report

REPORT_FILE=$REPORT_DIR/report.txt
REPORT_ERROR=$REPORT_DIR/report_error.txt
REPORT_VERSION=$REPORT_DIR/config_version.txt
REPORT_VERSION_FILE=$REPORT_DIR/config_diff.txt
REPORT_VERSION_FILE_OLD=$REPORT_DIR/config_diff2.txt
REPORT_TMP=$REPORT_DIR/tmp1.txt
REPORT_TMP_OLD=$REPORT_DIR/tmp2.txt

mkdir -p /tmp/oasis/ $REPORT_DIR
if [[ -f "$REPORT_TMP" ]]
then
	cp $REPORT_TMP $REPORT_TMP_OLD
else
	touch $REPORT_TMP_OLD
fi


$REPORT_SCRIPT_DIR/run_all.sh ./node_info/check_status.sh > $REPORT_TMP

#cat $REPORT_TMP


DIFF=$(diff -u $REPORT_TMP_OLD $REPORT_TMP)
if [ "$DIFF" != "" ]
then
	touch $REPORT_ERROR
	REPORT_ERROR_OLD=`cat $REPORT_ERROR`
	echo "Status has change"
	echo -e "`date`\n$DIFF\n\n\n$REPORT_ERROR_OLD\n" > $REPORT_ERROR
	$REPORT_SCRIPT_DIR/../api/ifttt.sh
fi

cp $REPORT_VERSION_FILE $REPORT_VERSION_FILE_OLD
#$REPORT_SCRIPT_DIR/run_all.sh ./config/config_auto.sh > $REPORT_VERSION_FILE
#DIFF=$(diff -u $REPORT_VERSION_FILE_OLD $REPORT_VERSION_FILE)
#if [ "$DIFF" != "" ]
#then
#	echo "Version has change"
#	echo -e "`date`\n$DIFF\n\n\n" > $REPORT_VERSION
#	#$REPORT_SCRIPT_DIR/../api/ifttt.sh
#fi


date > $REPORT_DIR/report.txt
echo >> $REPORT_DIR/report.txt
cat $REPORT_TMP >> $REPORT_DIR/report.txt






