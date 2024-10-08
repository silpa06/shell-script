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
echo "files:$FILES"

if [ ! -z "$FILES" ]
then
    echo "Files are found:"
    ZIPFILE="$DESTINATION_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip "$ZIPFILE" -@
    if [ -f $ZIPFILE ]
    then  
        echo "successfully zipped the files older than $DAYS"
        while ISF= read -r file
        do
            echo "dleleting file: $file"
            rm -rf $file
        done <<< $FILES
    else
        echo "zipping the files is unsuccesful"
        exit 1
    fi

    
else
    echo "no files older than $DAYS"
    exit 1
fi



# ZIPFILE="$DESTINATION_DIR/app-logs-$TIMESTAMP.zip"
#     find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip "$ZIPFILE" -@
#     if [ -f $ZIPFILE ]
#     then  
#         echo "successfully zipped the files older than $DAYS"
#         while ISF= read -r file
#         do
#             echo "dleleting file: $file"
#             rm -rf $file
#         done <<< $FILES
#     else
#         echo "zipping the files is unsuccesful"
#         exit 1
#     fi