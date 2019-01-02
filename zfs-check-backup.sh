#!/bin/bash

MAIL="/usr/bin/mail"
MAILFROM="backup@example.com"
MAILTO="support@example.com"

LIST="$(/sbin/zfs list -H -o name)"

#echo "$LIST"

DATE_YESTERDAY="$(date +'%Y-%m-%d' -d "yesterday")"
DATE_TODAY="$(date +'%Y-%m-%d')"

#echo "$DATE_YESTERDAY"
#echo "$DATE_TODAY"

#you can select to control by today or yesterday date
#DATE=$DATE_YESTERDAY
DATE=$DATE_TODAY

FAIL=""
FAILSNAPS=""

while read -r line
do
    latest=`/sbin/zfs list -t snapshot -H -S creation -o name -d 1 "$line" | head -1 | grep "zfs-auto-snap"`

    if [[ ! "$latest" == "" ]]; then

        #echo "$latest"

        
        if [[ "$latest" == *"$DATE"* ]]; then
            #echo "Stav: OK"
            continue
        else
            #echo "Stav: FAIL"
            FAILSNAPS+="\n$latest"
            FAIL="True"
        fi
    fi

done <<< "$LIST"

#echo -e "$FAILSNAPS"

if [[ $FAIL ]]; then
    BODY="ZFS backup missing: $FAILSNAPS"
    TITLE="ZFS backup missing"

    if [[ $MAILTO ]]; then
         echo -e $BODY | $MAIL -s "$TITLE" -a "From: $MAILFROM" $MAILTO
    fi
fi
