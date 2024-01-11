#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

cd $LOCAL_DIR
mkdir -p oasis-cli
cd oasis-cli
if [ ! -d "$OASIS_CLI_DIR" ]; then
	download_file $OASIS_CLI_TAR  $OASIS_CLI_URL
	tar -xf $OASIS_CLI_TAR
	rm -f $OASIS_CLI_TAR
else
	echo "Local dir $OASIS_CLI_DIR already exist"
fi




