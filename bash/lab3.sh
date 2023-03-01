#!/bin/bash


#install lxd if it isn't already installed
which lxd > /dev/null

if [ $? -ne 0 ]; then

  sudo apt update
  
    sudo apt install lxd -y
fi


ip a | grep -q lxdbr0 && echo "Interface found" || lxd init –auto

cat <<EOF 
EOF



lxc list | grep -w "COMP2101-S22" > /dev/null

if [ $? -ne 0 ]; then
	echo "Creating container COMP2101-S22 as Ubuntu 20.04 server"
	sudo lxc launch ubuntu:20.04 COMP2101-S22
	if [ $? -ne 0 ]; then
	
		echo "Container creation unsuccessful. Ending script execution"
		exit 1
	fi	
	while [ $(lxc list | grep -w "COMP2101-S22" | awk '{print $6}') = "|" ]; do
		sleep 5
	done
fi


grep -w "COMP2101-S22" /etc/hosts > /dev/null

if [ $? -ne 0 ]; then
	##VARIABLES##
	ip=$(lxc list | grep -w "COMP2101-S22" | awk '{print $6}')
	hostname="COMP2101-S22"
	#############
	echo "Adding COMP2101-S22 container to /etc/hosts"
	sudo sed -i.bkp " 2a $ip\t$hostname " /etc/hosts
	if [ $? -ne 0 ]; then
	# if it fails then it shows message and exits
		echo "Appending failed. Ending script execution"
		exit 1
	fi
fi


ip=$(lxc list | grep COMP2101-S22 | awk '{print $6}')
name=$(lxc list | grep COMP2101-S22 | awk '{print $2}')
curl $ip | grep -q Apache2 && echo "Apache already exist" ||lxc exec $name -- apt install apache2


cat <<EOF 
EOF


which curl > /dev/null
#curl will be installed if it's not already there.
if [ $? -ne 0 ]; then
	sudo apt install curl -y > /dev/null
	if [ $? -ne 0 ]; then
	
		echo "Curl installation failed. Ending script execution"
		exit 1
	fi
fi

#Test Apache2 in container
curl http://COMP2101-S22 >/dev/null 

if [ $? -eq 0 ]; then

  echo "the host can connect to the apache2 server in the container."
  
  else
  
    echo "the host failed connect to the apache2 server in the container."
    
    fi
exit
