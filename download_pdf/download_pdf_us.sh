#!/bin/bash

LIST_FILE=../vmworld-us-playback-urls.md
REFERER_URL=http://www.vmware.com

PDF_LIST=`cat $LIST_FILE | grep '\[PDF\]' | sed "s/.*(//g" | sed "s/)$//g"`

TOTAL=`echo "$PDF_LIST" | wc -l`

DL_COUNT=0

echo "$PDF_LIST" | while read L
do
    DL_COUNT=`expr $DL_COUNT + 1`
    FILE_NAME=`basename $L`

    echo "File $DL_COUNT/$TOTAL: $L"
    if [ -f $FILE_NAME ]; then
      echo "Skip DL: $FILE_NAME"
    else
      curl -s --referer $REFERER_URL -o $FILE_NAME $L
    fi
done
