#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
NONCE=`$SCRIPT_DIR/myoasis.sh stake account nonce`
echo $NONCE
