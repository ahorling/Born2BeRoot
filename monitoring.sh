#!/bin/bash
wall $'#Architecture:' `uname -a` \
$'\n#CPU physical :' `nproc` \
$'\n#vCPU :' `cat /proc/cpuinfo | grep processor | wc -l`\
$'\n'`free -m | awk 'NR==2{printf "#Memory Usage: %s/%sMB (%.2f%%)", $3, $2, ($3*100)/$2}'` \
$'\n'`df --output=used,avail --total | awk 'END {printf "#Disk Usage: %.1f/%.1fGb (%%%d)", $1/1000000, $2/1000000, ($1/$2)*100}'`\
$'\n'`top -bn1 | grep load | awk '{printf "#CPU load: %.2f\n", $(NF-2)}'` \
$'\n'`who -b | awk '{printf "#Last boot: %s %s %s", $3, $4, $5}'` \
$'\n#LVM use: ' `lsblk | grep lvm | awk '$1 ~ /lvm/ {print "yes"}' | awk 'NR==1'` \
$'\n#Connections TCP : '`netstat | grep ESTABLISHED | wc -l` 'ESTABLISHED' \
$'\n#User log: '`who | cut -d " " -f1 | sort -u | wc -l` \
$'\n#Network: '`hostname -I` `ip a | grep link/ether | awk '{printf "(%s)", $2}'` \
$'\n#Sudo :' `sudo grep 'sudo ' /var/log/auth.log | wc -l` 'total commands'
