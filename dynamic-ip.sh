#!/bin/bash
#
# @todo Don't hardwire full executable paths, but exit cleanly if they are not found
# @todo Add some basic help docs in comments here
# @todo Add some error handling for paths and missing config
# @todo Add a README file

# Save pwd and then change dir to this location
STARTDIR=`pwd`
cd `dirname $0`

# Creds
DOMAIN=`cat .domain`
PASSWORD=`cat .password`

# Get the local IP of the wifi adaptor
IP=`/sbin/ifconfig wlan | /usr/bin/awk '/inet addr/{print substr($2, 6)}'`

# Command to the DNS server
COMMAND="REPLACE pi-local 30 A $IP"

# Assemble the command
DATA="domain=${DOMAIN}&password=${PASSWORD}&command=${COMMAND}"
API="https://dnsapi4.mythic-beasts.com"

# See what we're doing
echo "Local IP address: $IP"
echo "API target: $API"
echo "Command: $COMMAND"

curl --show-error --data "$DATA" $API

# Go back to original dir
cd $STARTDIR
