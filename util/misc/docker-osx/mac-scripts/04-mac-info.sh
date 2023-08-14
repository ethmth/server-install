#!/bin/bash

# Get Ethernet MAC Address
mac_address=$(ifconfig en0 | awk '/ether/{print $2}')

source ~/.zshrc

macserial

csrutil status

echo "MAC Address: $mac_address"

echo "Make sure these values match those specified in values.conf"