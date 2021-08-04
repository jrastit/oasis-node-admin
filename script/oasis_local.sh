#!/bin/bash
. oasis_env.sh
CMDOASIS="$LOCAL_BIN $@"

echo $CMDOASIS >&2
$CMDOASIS

