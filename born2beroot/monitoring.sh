#!/bin/bash

echo -n "#Architecture: "; uname -a
echo -n "#CPU physical: "; grep -c "processor" /proc/cpuinfo
echo -n "#vCPU: "; grep -c "processor" /proc/cpuinfo
echo -n "#Memory Usage: "; free -m | awk 'NR==2{printf"%d/%dMB (%d5%c)\n", $2, $3, $3*100/$2, 37}'
echo -n "#Disk Usage: "; df -h / | awk 'NR==2{printf"%.1f/%.1fGB (%d%c)\n", $3, $4, $5, 37}'
echo -n "#CPU load: "; top -bn1 | grep load | awk '{printf"%.1f%c\n", $(NF-2), 37}'
echo -n "#Last boot: "; who -b | cut -d " " -f12-14
echo -n "#LVM use: "; if grep -q "/dev/mapper" /etc/fstab ; then echo "yes"; else echo "no"; fi
echo -n "#Connection TCP: "; netstat -s -t | grep "active connection" | cut -d " " -f5 | tr -d '\n' && echo " ESTABLISHED"
echo -n "#User log: "; who | wc -l
echo -n "#Network: IP "; hostname -I | tr -d '\n'; echo -n "("; ip addr | grep "link/ether" | cut -d " " -f6 | tr -d '\n'; echo ")"
