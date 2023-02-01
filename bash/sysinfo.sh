#!/bin/bash

# sysinfo.sh 

hostname=$(hostname)

operatingsystemname=$(hostnamectl)

ipaddress=$(hostname -I )

spaceaailinrootfilesystem=$(df -h | grep /dev/sda3 )

cat <<EOF
system;s fully-qualified domain name $hostname

Operating System And version :$Operatingsystem
Ip Address :$ipaddress
Root FIlesystem Free Status:$rootfilesystem

EOF
