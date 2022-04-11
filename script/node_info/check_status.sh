#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

HAS_ERROR=0

. $SCRIPT_DIR/oasis_env.sh
STATUS=`$SCRIPT_NODE_INFO_DIR/status.sh`
RESULT=$?
if [[ RESULT -ne 0 ]] ; then
  echo node error
  HAS_ERROR=1
  exit 1
fi

CORE_VERSION=`echo -e "$STATUS" | jq -r .software_version`

if [[ ${OASIS_CORE_VERSION} != ${CORE_VERSION}* ]] ; then
  echo core version error ${CORE_VERSION}/${OASIS_CORE_VERSION}
  HAS_ERROR=2
fi

if [ ! -z "$PARATIME_RUNTIME_VERSION" ] ; then 
  MAJOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .descriptor.deployments[-1].version.major'`
  MINOR=`echo -e "$STATUS" | jq -r '.["runtimes"] | .[] | .descriptor.deployments[-1].version.minor'`
  PARATIME_VERSION=$MAJOR.$MINOR
  if [[ ${PARATIME_RUNTIME_VERSION} != ${PARATIME_VERSION}* ]] ; then
    echo paratime version error ${PARATIME_VERSION}/${PARATIME_RUNTIME_VERSION}
    HAS_ERROR=3
  fi

fi

LATEST_TIME=`echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LATEST_TIME_DIFF=$((`date +"%s"` - $LATEST_TIME))
if [[ ${LATEST_TIME_DIFF} -gt "60" ]] ; then
  echo latest time error
  HAS_ERROR=4
fi

LAST_REGISTRATION=`echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LAST_REGISTRATION_DIFF=$((`date +"%s"` - $LAST_REGISTRATION))
if [[ ${LAST_REGISTRATION_DIFF} -gt "4000" ]] ; then
  echo last registration error
  HAS_ERROR=5
fi

if [[ "$HAS_ERROR" == "0" ]]; then
  echo node registered
fi

exit $HAS_ERROR


