
#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "oasis disk name sda,sdb,..."
read OASIS_DISK_NAME

$REMOTE_CMD_ADMIN parted /dev/$OASIS_DISK_NAME --script mklabel gpt mkpart xfspart xfs 0% 100%
$REMOTE_CMD_ADMIN mkfs.xfs /dev/${OASIS_DISK_NAME}1 
$REMOTE_CMD_ADMIN partprobe /dev/${OASIS_DISK_NAME}1 
$REMOTE_CMD_ADMIN blkid | grep ${OASIS_DISK_NAME}1 

