#!/bin/bash
# This is a script to display information about a computer.

#Hostname of the system
Hostname=$(hostname)

# Fully-Qualified Domain Name of the system.
FQDN=$(hostname --fqdn)

#Host information and OS info
Host_Information=$(hostnamectl)

#IP address
IP_address=$(hostname -I)

#Free space avaliable in Root File
Free_Space=$(df -h /dev/sda3 | tail -1 | awk '{print $4}')

cat <<EOF
 Report for $Hostname
#################################
 FQDN: $FQDN
 Host Information and OS info: $Host_Information
 IP Address: $IP_address
 Root Filesystem Free space: $Free_Space
################################
EOF
