#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

# echo $REMOTE_CMD_ADMIN echo "blacklist intel_sgx"

# $REMOTE_CMD_ADMIN "echo \"blacklist intel_sgx\" | sudo tee -a /etc/modprobe.d/blacklist-intel_sgx.conf >/dev/null"

# $REMOTE_CMD_ADMIN "echo \"deb https://download.fortanix.com/linux/apt xenial main\" | sudo tee /etc/apt/sources.list.d/fortanix.list >/dev/null"
# $REMOTE_CMD_ADMIN "curl -sSL \"https://download.fortanix.com/linux/apt/fortanix.gpg\" | sudo -E apt-key add -"

# $REMOTE_CMD_ADMIN "echo \"deb https://download.01.org/intel-sgx/sgx_repo/ubuntu \$(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/intel-sgx.list >/dev/null"
# $REMOTE_CMD_ADMIN "curl -sSL \"https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key\" | sudo -E apt-key add -"


$REMOTE_CMD_ADMIN "curl -fsSL https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | sudo gpg --dearmor -o /usr/share/keyrings/intel-sgx-deb.gpg"
$REMOTE_CMD_ADMIN "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/intel-sgx-deb.gpg] https://download.01.org/intel-sgx/sgx_repo/ubuntu $(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/intel-sgx.list > /dev/null"

echo $REMOTE_CMD_ADMIN apt-get update
$REMOTE_CMD_ADMIN apt-get update

echo $REMOTE_CMD_ADMIN apt-get install sgx-aesm-service libsgx-aesm-ecdsa-plugin libsgx-aesm-quote-ex-plugin libsgx-dcap-default-qpl intel-microcode
$REMOTE_CMD_ADMIN "apt-get install sgx-aesm-service libsgx-aesm-ecdsa-plugin libsgx-aesm-quote-ex-plugin libsgx-dcap-default-qpl intel-microcode"

# echo fix SGX /dev issue $REMOTE_CMD_ADMIN "sed -i s/devsgx=y/devsgx=n/g /etc/modprobe.d/fortanix-isgx.conf"
# $REMOTE_CMD_ADMIN sed -i s/devsgx=y/devsgx=n/g /etc/modprobe.d/fortanix-isgx.conf
$REMOTE_CMD_ADMIN "sudo sed -i 's|\"pccs_url\": \"https://localhost:8081/sgx/certification/v4/\"|\"pccs_url\": \"https://api.trustedservices.intel.com/sgx/certification/v4/\"|' /etc/sgx_default_qcnl.conf"




