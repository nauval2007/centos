#!/bin/bash
#
# Copyright by Shien Ikiru
# ================================
# 

data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

#echo "------------------------"
date
#echo "----------------------------";
#echo 
echo "---------------------------------------------------------------------";
echo " Program PID	User		From			Login Time"
echo "---------------------------------------------------------------------";

for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	TIME=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" |grep "dropbear\[$PID\]" | awk '{print $1" "$2" "$3}'`;
	if [ $NUM -eq 1 ]; then
		echo "dropbear  $PID  	$USER	$IP		$TIME";
	fi
done
#echo "---------------------------------------------------------------------";

# tanpa root
#data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

data=( `ps aux | grep "sshd" | sort -k 72 | awk '{print $2}'`);

#echo 
#echo "			Checking OpenSSH login";

#echo "---------------------------------------------------------------------";
#echo " PID	User		From 			Login Time";
#echo "---------------------------------------------------------------------";

for PID in "${data[@]}"
do
        #echo "check $PID";
		NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
		USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
		IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11":"$13}'`;
		TIME=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" |grep "sshd\[$PID\]" | awk '{print $1" "$2" "$3}'`;
        if [ $NUM -eq 1 ]; then
                echo "openssh  $PID 	$USER 	$IP		$TIME";
        fi
done

#echo 
#echo "			Checking PPTP Login"
#echo "---------------------------------------------------------------------";
echo "PPTP	"|last | grep ppp | grep still


#echo 
#echo "			Checking Open VPN Login"
#echo "---------------------------------------------------------------------";
/root/vpnmonhist

echo "---------------------"
echo "Shien Ikiru (c) 2015";
