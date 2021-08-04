#!/bin/bash

. ./oasis_env.sh

echo $NETWORK_BIN $@
$NETWORK_BIN $@

