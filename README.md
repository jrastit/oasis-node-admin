# oasis

> Local dependency jq
sudo apt-get install jq

## Install cipher paratime node

###Admin host
./script/admin/install_system.sh
./script/admin/install_sgx.sh
./script/admin/add_oasis_user.sh
./script/admin/install_prerequisit.sh
./script/admin/reboot_system.sh

###
cd script/node_admin/ 
./new_node_paratime_sgx.sh
cd ../install
./install_core.sh
./install_genesis.sh
./install_paratime_sgx.sh
cd ../cmd
./oasis_start.sh

