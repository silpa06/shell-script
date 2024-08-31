#!/bin/bash
SOURCE_DIR=/home/ec2-user/logs
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIR ]
then
    echo -e "source directory is $G exist $N"
else
    echo -e "source directory $R doen not exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtimes +14)
if [ -z FILES ]
then
    echo "no files older than 14 days"
    exit 1
else
    echo "files: $FILES"
    while ISF= read -r file
    do
        echo "deleting the file: $file"
        rm -rf $file
    done <<< $FILES
fi 