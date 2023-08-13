#!/bin/bash

# Get Ethernet MAC Address
mac_address=$(ifconfig en0 | awk '/ether/{print $2}')

macserial

echo "MAC Address: $mac_address"

echo "Make sure these values match those specified in values.conf"