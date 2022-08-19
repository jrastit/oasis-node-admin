#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo Install system
$SCRIPT_DIR/system_admin/install_system.sh
echo Install prerequisit
$SCRIPT_DIR/system_admin/install_prerequisit.sh
echo Install prerequisit paratime
$SCRIPT_DIR/system_admin/install_paratime.sh
echo Add oasis user
$SCRIPT_DIR/system_admin/add_oasis_user.sh
echo Disk info
$SCRIPT_DIR/system_admin/disk_info.sh
echo Disk create partition
$SCRIPT_DIR/system_admin/disk_create_partition.sh
echo Update fstab
$SCRIPT_DIR/system_admin/add_oasis_fstab.sh



