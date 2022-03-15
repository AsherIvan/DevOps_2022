#!/bin/bash

#Processor info
echo "Processor info" > sys_results.txt
FILE="/proc/cpuinfo"
if [ -f "$FILE" ]
then
	THREADS_NUM=0
	STR="processor"
	IFS=$' \t:\n'
	for VAR in $(cat "$FILE")
	do
		if [ "$VAR" = "$STR" ]
		then
			THREADS_NUM=$[ "$THREADS_NUM" + 1 ]
		fi
	done
	echo "THREADS_NUM=$THREADS_NUM" >> sys_results.txt
	if [ "$THREADS_NUM" -ne 0 ]
	then
		IFS=$'\n'
		COUNT=0
		for VAR in $(cat "$FILE")
		do
			if [ "$COUNT" -eq 0 ]
			then
				COUNT=$[ "$COUNT" + 1 ]
				continue
			fi
			echo "$VAR"
			COUNT=$[ "$COUNT" + 1 ]
			if [ "$COUNT" -eq 24 ]
			then
				break
			fi
		done >> sys_results.txt
	fi
	echo -e "\n\n" >> sys_results.txt
else
	echo -e "File $FILE doesn't exist or it is a directory\n\n" >> sys_results.txt
fi

#Memory info
echo "Memory info" >> sys_results.txt
FILE="/proc/meminfo"
IFS=$'\n'
if [ -f "$FILE" ]
then
	for VAR in $(cat "$FILE")
	do
 		echo "$VAR"
	done >> sys_results.txt
	echo -e "\n\n" >> sys_results.txt
else
	echo -e "File $FILE doesn't exist or it is a directory\n\n" >> sys_results.txt
fi

#Disk info
echo "The /proc/diskstats file displays the I/O statistics of block devices. Each line contains the following 20 fields" >> sys_results.txt
FILE=/proc/diskstats
IFS=$'\n'
NAMES=( "major number" "minor mumber" "device name" "reads completed successfully" "reads merged" "sectors read" "time spent reading (ms)" "writes completed" "writes merged" "sectors written" "time spent writing (ms)" "I/Os currently in progress" "time spent doing I/Os (ms)" "weighted time spent doing I/Os (ms)" "discards completed successfully" "discards merged" "sectors discarded" "time spent discarding" "flush requests completed successfully" "time spent flushing" )
if [ -f "$FILE" ]
then
	COUNT=1
	for VAR in "${NAMES[@]}"
	do
		echo -e "$COUNT. $VAR"
		COUNT=$[ "$COUNT" + 1 ]
	done >> sys_results.txt
	for LINE in $(cat "$FILE")
	do
		echo "$LINE"
	done >> sys_results.txt
	echo -e "\n\n" >> sys_results.txt
else
echo -e "File $FILE doesn't exist or it is a directory\n\n" >> sys_results.txt
fi

#Devices info
echo "Devices info" >> sys_results.txt
FILE="/proc/devices"
if [ -f "$FILE" ]
then
	for VAR in $(cat "$FILE")
	do
		echo "$VAR"
	done >> sys_results.txt
	echo -e "\n\n" >> sys_results.txt
else
echo -e "File $FILE doesn't exist or it is a directory\n\n" >> sys_results.txt
fi
