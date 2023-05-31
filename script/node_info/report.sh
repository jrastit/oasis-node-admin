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

. $SCRIPT_DIR/oasis_env.sh
STATUS=`$SCRIPT_NODE_INFO_DIR/status.sh`
RESULT=$?
if [[ RESULT -ne 0 ]] ; then
  echo node error
  exit 1
fi

#echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .committee'
#exit 0

#echo ${OASIS_CORE_VERSION}
CORE_VERSION=`echo -e "$STATUS" | jq -r .software_version`

if [[ ${OASIS_CORE_VERSION} != ${CORE_VERSION}* ]] ; then
  echo core version error ${CORE_VERSION}/${OASIS_CORE_VERSION}
fi

#echo Paratime
#echo $PARATIME_RUNTIME_VERSION
if [ ! -z "$PARATIME_RUNTIME_VERSION" ] ; then 
  PARATIME_VERSION=$(paratime_version "$STATUS")
  if [[ ${PARATIME_RUNTIME_VERSION} != ${PARATIME_VERSION}* ]] ; then
    echo paratime version error ${PARATIME_VERSION}/${PARATIME_RUNTIME_VERSION}
  fi
fi
#echo Latest Time
LATEST_TIME=`echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LATEST_TIME_DIFF=$((`date +"%s"` - $LATEST_TIME))
if [[ ${LATEST_TIME_DIFF} -gt "$LATEST_TIME_ERROR" ]] ; then
  echo latest time error
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
	  echo last registration error
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
if [ -z "$PARATIME_RUNTIME_VERSION" ] ; then 
  echo $CORE_VERSION/${OASIS_CORE_VERSION} $DISPLAY_TIME $REGISTRATION $VALIDATOR
else
  echo $CORE_VERSION/${OASIS_CORE_VERSION} - $PARATIME_VERSION/$PARATIME_RUNTIME_VERSION $DISPLAY_TIME $REGISTRATION $VALIDATOR
fi

$SSHCMD "cd $OASIS_NODE_ROOT_DIR && df -h ."

