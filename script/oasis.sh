#!/bin/bash

. ./oasis_env.sh

echo $NETWORK_BIN -a $NETWORK_ADDR $@
$NETWORK_BIN -a $NETWORK_ADDR $@

