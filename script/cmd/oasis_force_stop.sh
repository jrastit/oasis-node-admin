#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $SSHCMD pidof oasis-node 
PID=`$SSHCMD pidof oasis-node`
echo $PID
if [[ ! -z "$PID" ]]; then
  echo $SSHCMD kill -INT $PID
  $SSHCMD kill -INT $PID
  while [[ ! -z "$PID" ]]; do
     echo wait
     PID=`$SSHCMD pidof oasis-node`
     echo $PID
     sleep 1 
  done
fi
