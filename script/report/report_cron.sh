#!/bin/bash
REPORT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" &> /dev/null && pwd )"

echo $REPORT_SCRIPT_DIR

mkdir -p /tmp/oasis/
cp /tmp/oasis/report.txt /tmp/oasis/report_old.txt
$REPORT_SCRIPT_DIR/report_all.sh ./node_info/check_status.sh > /tmp/oasis/report.txt
#cat /tmp/oasis/report.txt

DIFF=$(diff -u /tmp/oasis/report.txt /tmp/oasis/report_old.txt) 
if [ "$DIFF" != "" ] 
then
    touch /var/www/oasis/report_error.txt
    echo "Status has change"
    echo >> /var/www/oasis/report_error.txt
    date >> /var/www/oasis/report_error.txt
    echo >> /var/www/oasis/report_error.txt
    echo -e "$DIFF" >> /var/www/oasis/report_error.txt
fi

date > /var/www/oasis/report.txt
echo >> /var/www/oasis/report.txt
cat /tmp/oasis/report.txt >> /var/www/oasis/report.txt






