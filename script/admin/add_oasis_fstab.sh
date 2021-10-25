
#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"
. $SCRIPT_DIR/oasis_env.sh

echo "oasis disk UUID"
read OASIS_UUID

echo $REMOTE_CMD_ADMIN "\"echo 'UUID=$OASIS_UUID /oasis auto defaults,nofail,x-systemd.requires=cloud-init.service,comment=cloudconfig 0 2' >> /etc/fstab\""
$REMOTE_CMD_ADMIN "bash -c \"echo 'UUID=$OASIS_UUID /oasis auto defaults,nofail,x-systemd.requires=cloud-init.service,comment=cloudconfig 0 2' >> /etc/fstab\""
