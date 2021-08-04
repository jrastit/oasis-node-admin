#/bin/bash
./info.sh | awk '/Available\:/{print gensub("\\.", "", "g", $2)}'

