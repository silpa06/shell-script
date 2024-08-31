#!/bin/bash
SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

if [ $# -lt 2 ]
then
    echo "usage: sh backup.sh <source> <destination> <days(optional)>"
    exit
fi

if [ ! -d $SOURCE_DIR ]
then    
    echo "source directory is not exist"
    exit 1
else
    echo "source directory is exist"
fi

if [ ! -d $DESTINATION_DIR ]
then    
    echo "destination directory is not exist"
    exit 1
else
    echo "destination directory is exist"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "files"$FILES"

