#/bin/bash
./info.sh | awk 'ct == 2 {print gensub(/\./, "", "g", $2), $3} ct == 2 {ct = 0} ct == 1 && $2 ~ /To:/{ct++} /Active Delegations from this Account\:/{ct = 1}'

