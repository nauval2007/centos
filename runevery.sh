#!/bin/bash
# Wrapper

# Initialisation
if [ "$1" == "" ]; then
echo "Usage: runevery seconds"
exit 1
fi

interval=$1


next=$(date +%M | awk -v interval=$interval '{ print int($0 * 60 % interval) }')

if [ $next -gt 0 ]; then
next=$(echo $next | awk -v interval=$interval '{print interval - $0}')
fi


for i in $(seq $next $interval 59)
do
(sleep $i; /root/userlimit.sh 2; /root/userlimit-os.sh 2; /root/userexpired.sh) &
#(sleep $i; echo "i'm running every $interval") &
done 