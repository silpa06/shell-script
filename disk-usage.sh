#!/bin/bash
DISK_USAGE=$(df -hT | grep xfs)
THRESHOLD=5

while ISF= read -r line
do
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -gt $THRESHOLD ]
    then
        echo "$PARTITION is more than $THRESHOLD, current value: $USAGE. please check"
    fi
done <<< $DISK_USAGE
