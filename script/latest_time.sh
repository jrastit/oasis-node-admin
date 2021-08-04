./status.sh | grep latest_time | awk '{print substr($2, 2, length($2)-3)}' | xargs date -d
