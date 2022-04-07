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
#echo ${OASIS_CORE_VERSION}
CORE_VERSION=`echo -e "$STATUS" | jq -r .software_version`

if [[ ${OASIS_CORE_VERSION} != ${CORE_VERSION}* ]] ; then
  echo core version error ${CORE_VERSION}/${OASIS_CORE_VERSION}
fi

#echo Paratime
#echo $PARATIME_RUNTIME_VERSION
if [ ! -z "$PARATIME_RUNTIME_VERSION" ] ; then 
  MAJOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .descriptor.deployments[-1].version.major'`
  MINOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .descriptor.deployments[-1].version.minor'`
  PARATIME_VERSION=$MAJOR.$MINOR
  if [[ ${PARATIME_RUNTIME_VERSION} != ${PARATIME_VERSION}* ]] ; then
    echo paratime version error ${PARATIME_VERSION}/${PARATIME_RUNTIME_VERSION}
  fi
fi
#echo Latest Time
LATEST_TIME=`echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LATEST_TIME_DIFF=$((`date +"%s"` - $LATEST_TIME))
if [[ ${LATEST_TIME_DIFF} -gt "60" ]] ; then
  echo latest time error
fi
#displaytime LATEST_TIME_DIFF
#echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date -d 2>/dev/null
#echo Last Registration
LAST_REGISTRATION=`echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LAST_REGISTRATION_DIFF=$((`date +"%s"` - $LAST_REGISTRATION))
if [[ ${LAST_REGISTRATION_DIFF} -gt "4000" ]] ; then
  echo last registration error
fi
#displaytime LAST_REGISTRATION_DIFF
#echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date -d 2>/dev/null
if [ -z "$PARATIME_RUNTIME_VERSION" ] ; then 
  echo $CORE_VERSION/${OASIS_CORE_VERSION} - `displaytime $LATEST_TIME_DIFF` - `displaytime $LAST_REGISTRATION_DIFF`
else
  echo $CORE_VERSION/${OASIS_CORE_VERSION} - $PARATIME_VERSION/$PARATIME_RUNTIME_VERSION - `displaytime $LATEST_TIME_DIFF` - `displaytime $LAST_REGISTRATION_DIFF`
fi

