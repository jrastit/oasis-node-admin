#!/bin/bash
SCRIPT_NODE_INFO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

HAS_ERROR=0

. $SCRIPT_DIR/oasis_env.sh
. $SCRIPT_DIR/paratime_env.sh

STATUS=`$SCRIPT_NODE_INFO_DIR/status.sh`
RESULT=$?
if [[ RESULT -ne 0 ]] ; then
  echo node error
  HAS_ERROR=1
  exit 1
fi

ERROR=""
paratime_info_all $STATUS


LATEST_TIME=`echo -e "$STATUS" | jq -r .consensus.latest_time 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
LATEST_TIME_DIFF=$((`date +"%s"` - $LATEST_TIME))
if [[ ${LATEST_TIME_DIFF} -gt "$LATEST_TIME_ERROR" ]] ; then
  ERROR="$ERROR latest time error\n"
  HAS_ERROR=1
fi

if [[ "$OASIS_NODE_REGISTER" == "true" ]] ; then
	LAST_REGISTRATION=`echo -e "$STATUS" | jq -r .registration.last_registration 2>/dev/null | xargs date +"%s" -d 2>/dev/null`
	LAST_REGISTRATION_DIFF=$((`date +"%s"` - $LAST_REGISTRATION))
	if [[ ${LAST_REGISTRATION_DIFF} -gt "$REGISTER_TIME_ERROR" ]] ; then
	  ERROR="$ERROR latest registration error\n"
	  HAS_ERROR=5
	fi
fi

echo "$OASIS_NODE_NAME $INFO"
echo -e "$ERROR" | sed -z '$ s/\n$//'

#IS_VALIDATOR=`echo -e "$STATUS" | jq -r .consensus.is_validator 2>/dev/null`
#if [[ "$IS_VALIDATOR" == "true" ]] ; then
#	echo Validator
#fi

exit $HAS_ERROR


