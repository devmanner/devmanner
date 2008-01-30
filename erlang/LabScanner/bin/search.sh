#!/bin/bash
# Setup:
LOG_DIR=/net/wsl2010/export/raid02/LabScanner/

if [ "$1" = "-h" ]
then
    echo "Usage: $0 [-all] SERIAL"
    exit
fi

if [ "$1" = "-all" ]
then
    SERIAL=$2
    DISPLAY_ALL=1
else
    SERIAL=$1
    DISPLAY_ALL=0
fi

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------"
echo "| Seen at           | Site	| Subrack	| Slot	| Product             | Revision  | Type      | Serial         | Date      | Vendor         |"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------"

PREV_FOUND=""

for HWFILE in `ls $LOG_DIR/hw*`
do
    FOUND=`cat $HWFILE | grep %% | grep $SERIAL | sed -e 's/%%//'`
    if [ $DISPLAY_ALL = 1 ] || [ "$FOUND" != "$PREV_FOUND" ]
    then
	DATE_TIME=`basename $HWFILE | awk '{split($0,arr,"_"); print arr[2] " " arr[3]}'`
	if [ "$DATE_TIME" = " " ]
	then
	    DATE_TIME="Latest             "
	fi
	echo "$DATE_TIME$FOUND"
	PREV_FOUND=$FOUND
    fi
done

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------"
