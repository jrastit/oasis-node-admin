#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S
}

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
ERROR=""

. $SCRIPT_DIR/oasis_env.sh
. $SCRIPT_DIR/paratime_env.sh

FREE_DISK=`$SSHCMD "cd $OASIS_NODE_ROOT_DIR && df -h ."`
RESULT=$?

if [[ RESULT -ne 0 ]] ; then
  echo -e "$OASIS_NODE_NAME${RED} not responding ${NC} $OASIS_NODE_ADDR"
  exit 1
fi

SERVICE_STATUS=`$REMOTE_CMD systemctl --user is-active oasis_$OASIS_NODE_NAME.service`

FREE_DISK_INFO=`echo $FREE_DISK | awk 'NR==1 {print $10"/"$9}'`
FREE_DISK_SCORE=`echo $FREE_DISK | awk 'NR==1 {print $12}' | tr -d '%'`
if (( $FREE_DISK_SCORE >= 90 )); then
	FREE_DISK_INFO="${RED}$FREE_DISK_INFO $FREE_DISK_SCORE%${NC}"
elif (( $FREE_DISK_SCORE >= 75 )); then
	FREE_DISK_INFO="${YELLOW}$FREE_DISK_INFO $FREE_DISK_SCORE%${NC}"
else
	FREE_DISK_INFO="${GREEN}$FREE_DISK_INFO $FREE_DISK_SCORE%${NC}"
fi

STATUS=`$SCRIPT_NODE_INFO_DIR/status.sh`
RESULT=$?
if [[ RESULT -ne 0 ]] ; then
  echo -e "$OASIS_NODE_NAME $SERVICE_STATUS${RED} status error ${NC}$FREE_DISK_INFO $OASIS_NODE_ADDR"
  exit 1
fi

#echo Latest Time
LATEST_TIME=`echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LATEST_TIME_DIFF=$((`date +"%s"` - $LATEST_TIME))
if [[ ${LATEST_TIME_DIFF} -gt "$LATEST_TIME_ERROR" ]] ; then
  ERROR="$ERROR last time error\n"
fi
DISPLAY_TIME="- `displaytime $LATEST_TIME_DIFF`"
if [[ ${LASTEST_TIME_DIFF} -gt "60000000000" ]] ; then
  DISPLAY_TIME="- not started" 
fi
#displaytime LATEST_TIME_DIFF
#echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date -d 2>/dev/null
#echo Last Registration
if [[ "$OASIS_NODE_REGISTER" == "true" ]] ; then
	LAST_REGISTRATION=`echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date +"%s" -d 2>/dev/null` 
	LAST_REGISTRATION_DIFF=$((`date +"%s"` - $LAST_REGISTRATION))
	if [[ ${LAST_REGISTRATION_DIFF} -gt "$REGISTER_TIME_ERROR" ]] ; then
	  ERROR="$ERROR last registration error\n"
	fi
	REGISTRATION="- `displaytime $LAST_REGISTRATION_DIFF`"
	if [[ ${LAST_REGISTRATION_DIFF} -gt "60000000000" ]] ; then
	  REGISTRATION="- not started" 
	fi
fi
IS_VALIDATOR=`echo -e "$STATUS" | jq -r .consensus.is_validator 2>/dev/null`
if [[ "$IS_VALIDATOR" == "true" ]] ; then
	VALIDATOR=' Validator'
fi
#displaytime LAST_REGISTRATION_DIFF
#echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date -d 2>/dev/null
#if [ -z "$PARATIME_RUNTIME_VERSION" ] ; then 
#  echo $CORE_VERSION/${OASIS_CORE_VERSION} $DISPLAY_TIME $REGISTRATION $VALIDATOR
#else
#  echo $CORE_VERSION/${OASIS_CORE_VERSION} - $PARATIME_VERSION/$PARATIME_RUNTIME_VERSION $DISPLAY_TIME $REGISTRATION $VALIDATOR
#fi
paratime_info_all $STATUS

if [[ $ERROR != "" ]] ; then
	echo -e "$OASIS_NODE_NAME $SERVICE_STATUS${RED}$INFO $DISPLAY_TIME $REGISTRATION $VALIDATOR ${NC}$FREE_DISK_INFO $OASIS_NODE_ADDR"
	echo -e "${RED}$ERROR${NC}" | sed -z '$ s/\n$//'
else
	echo -e "$OASIS_NODE_NAME $SERVICE_STATUS${GREEN}$INFO $DISPLAY_TIME $REGISTRATION $VALIDATOR ${NC}$FREE_DISK_INFO $OASIS_NODE_ADDR"	
fi


