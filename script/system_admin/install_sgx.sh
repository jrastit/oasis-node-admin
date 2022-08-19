#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo $REMOTE_CMD_ADMIN echo "blacklist intel_sgx"

$REMOTE_CMD_ADMIN "echo \"blacklist intel_sgx\" | sudo tee -a /etc/modprobe.d/blacklist-intel_sgx.conf >/dev/null"

$REMOTE_CMD_ADMIN "echo \"deb https://download.fortanix.com/linux/apt xenial main\" | sudo tee /etc/apt/sources.list.d/fortanix.list >/dev/null"
$REMOTE_CMD_ADMIN "curl -sSL \"https://download.fortanix.com/linux/apt/fortanix.gpg\" | sudo -E apt-key add -"

$REMOTE_CMD_ADMIN "echo \"deb https://download.01.org/intel-sgx/sgx_repo/ubuntu \$(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/intel-sgx.list >/dev/null"
$REMOTE_CMD_ADMIN "curl -sSL \"https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key\" | sudo -E apt-key add -"


echo $REMOTE_CMD_ADMIN apt-get update
$REMOTE_CMD_ADMIN apt-get update

echo $REMOTE_CMD_ADMIN apt-get install intel-sgx-dkms sgx-aesm-service libsgx-aesm-launch-plugin libsgx-aesm-epid-plugin
$REMOTE_CMD_ADMIN apt-get install intel-sgx-dkms sgx-aesm-service libsgx-aesm-launch-plugin libsgx-aesm-epid-plugin

echo fix SGX /dev issue $REMOTE_CMD_ADMIN "sed -i s/devsgx=y/devsgx=n/g /etc/modprobe.d/fortanix-isgx.conf"
$REMOTE_CMD_ADMIN sed -i s/devsgx=y/devsgx=n/g /etc/modprobe.d/fortanix-isgx.conf





