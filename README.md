# oasis node admin

Bash script to manage oasis node  
this script is to run from a linux client that have ssh acces to the server  
you can enable ssh with ssh-copy-id to avoid password prompt  

## Local dependency jq
`sudo apt-get install jq`  
use the script directory  
`cd script`  

## Install paratime node

### Configure the node
Set the node name as environment:  
`. ./set_node.sh testnet_emerald2`  
Your invite should be: oasis@asus>testnet_emerald2:~/oasis-node-admin/script  

#### Configure your node answering questions
`./config/config_node.sh`  
You should obtain something like:  
>CUSTOM_OASIS_NODE_ENTITY="my_entity"  
>CUSTOM_OASIS_NODE_NETWORK="testnet"  
>CUSTOM_OASIS_NODE_TYPE="emerald"  
>CUSTOM_OASIS_NODE_ROOT_DIR="/home/oasis"  
>CUSTOM_OASIS_NODE_ADDR="20.80.34.71"  
>CUSTOM_OASIS_NODE_PORT="26650"  
>CUSTOM_OASIS_NODE_SSH_NAME="oasis"  
>CUSTOM_OASIS_NODE_SSH_ADMIN_NAME="oasis"  

#### Configure the network answering questions
`./config/config_network.sh`  
You should obtain something like:  
>CUSTOM_OASIS_CORE_VERSION="21.3.6"  
>CUSTOM_OASIS_GENESIS_URL="https://github.com/oasisprotocol/testnet-artifacts/releases/download/2021-04-13/genesis.json"  
>CUSTOM_OASIS_SEED_NODE="05EAC99BB37F6DAAD4B13386FF5E087ACBDDC450@34.86.165.6:26656"  

#### Configure the node type answering questions
`./config/config_type.sh`  
You should obtain something like:  
>CUSTOM_PARATIME_RUNTIME_IDENTIFIER="00000000000000000000000000000000000000000000000072c8215e60d5bca7"  
>CUSTOM_PARATIME_RUNTIME_VERSION="6.0.0-rc"  


### Admin host if needed 
./script/admin/install_system.sh  
./script/admin/install_prerequisit.sh  
#for cipher SGX (used for Microsoft azure sgx)
./script/admin/install_sgx.sh  


### install user
./script/admin/add_oasis_user.sh  

### Setup disk
#Retrive information
./script/admin/disk_info.sh
#Create partition if needed (Cloud network disk)
./script/admin/disk_create_partition.sh
#Add the partition to fstab
./script/admin/add_oasis_fstab.sh
#reboot the system
./script/admin/reboot_system.sh  

### Create the need file for the node

#### Create the entity
`./entity_admin/create_entity.sh`  

#### Create the oasis node config file
`./node_admin/create_node.sh`  

#### Install the genesis file (Local and remote)
`./install/install_genesis.sh`  

#### Install the core binary file (Local and remote)
`./install/install_core.sh`  

#### Install the paratime binary file if needed
`./install/install_paratime_emerald.sh`  

#### Create the configuration file for your node
`./node_admin/config_node.sh`  

### Start the node

#### Run the node
`./cmd/oasis_start.sh`  

or Run the node with screen  
`./cmd/oasis_start_screen.sh`  
and then to access the display  
`./cmd/oasis_screen.sh`  

### update the node when version change
Stop the node, ctrl + c when in the consol  
`./cmd/oasis_screen.sh`  

#### Set the new version
`./config/config_network.sh`  
or  
`./config/config_type.sh`  

#### Install the binary file that have change
Install the core binary file if needed (Local and remote)  
`./install/install_core.sh`  

Install the paratime binary file if needed  
`./install/install_paratime_emerald.sh`  

#### Update the configuration
`./node_admin/config_node_validator.sh`  
or  
`./node_admin/config_node_emerald.sh`  
...

#### Start the node again
`./cmd/oasis_start_screen.sh`  

## usefull command

### swith between node
`. ./set_node.sh`  

### entity info
#### get balance
`./entity_info/balance.sh`  
> 1434763458467 ROSE  
#### get entity address
`./entity_info/get_entity_address.sh`  
> oasis1qz26ty8q6gwt6zah7dtt8jpepvwnttkg8ssnxjl7  
#### get entity id
`./entity_info/get_entity_id.sh`  
> kupW3Pt0XMeERSkdDWyZMU4oZrk0wGysVXVyqX3rylc=  
#### get stake amount (self)
`./entity_info/get_stake_amount.sh`  
#### get ROSE availlable
`./entity_info/get_stake_available.sh`  
#### get number of share (self)
`./entity_info/get_stake_share.sh`  
#### full info for network stake
`./entity_info/stake_info.sh`  
#### full entity info
`./entity_info/entity_info.sh`  
#### nonce
`./entity_info/nonce.sh`  

### node info
#### configuration file in production
`./node_info/config_prod.sh`  
#### has completed sync
`./node_info/is-synced.sh`  
#### latest tile (last block time)
`./node_info/latest_time.sh`  
> samedi 4 décembre 2021, 17:51:39 (UTC+0100)  
#### last registration time (if success)
`./node_info/last_registration.sh`  
#### node id
`./node_info/node_id.sh`  
#### full status
`./node_info/status.sh`  

### report
#### launch command for all nodes
`./report/report_all.sh ./node_info/latest_time.sh`  
>NODE cipher  
>samedi 4 décembre 2021, 18:22:20 (UTC+0100)  
>  
>NODE emerald  
>samedi 4 décembre 2021, 18:22:20 (UTC+0100)  
>  
>NODE mainnet  
>samedi 4 décembre 2021, 18:22:20 (UTC+0100)  
>  
>NODE mainnetClu  
>samedi 4 décembre 2021, 18:22:26 (UTC+0100)  
>  
>NODE testnet  
>samedi 4 décembre 2021, 18:22:29 (UTC+0100)  
>  
>NODE testnet_emerald  
>samedi 4 décembre 2021, 18:22:29 (UTC+0100)  
>  
>NODE testnet_emerald2  
  
### entity admin
#### update_entity
update the node list for the entity, find all the configured node and send the list to the server  
(node need to be started)  
`./entity_admin/entity_update.sh`  
#### update entity manualy
enter the list of node separated by ,  
`entity_update_manual.sh`  

### node admin
vote for a proposal filling the id  
`./node_admin/gen_cast_vote.sh`  

set the comission rate for the node  
`./node_admin/set_commission_rate.sh`  

open a shell on the node  
`remote_shell.sh`  

copy exiting node data to the new node (enter the server path for old node)  
`./node_admin/copy_from_node.sh`  

### stake
Add rose to the stake (self)  
`./stake/add_self_stake.sh`  

Add rose to a validator  
`./stake/add_stake.sh`  

Remove all staked ROSE (self)  
`./stake/unstakeALL.sh`  

### transfer
transfer ROSE  
`./transfer/transfer.sh`  

withdraw all ROSE except 2000  
`./transfer/WithdrawAll.sh`  

