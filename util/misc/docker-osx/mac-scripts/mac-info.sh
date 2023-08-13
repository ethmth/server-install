#!/bin/bash

# Get Serial Number
serial_number=$(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $4}')

# Get Ethernet MAC Address
mac_address=$(ifconfig en0 | awk '/ether/{print $2}')

# Get Board Serial Number and Model Number
board_serial_number=$(system_profiler SPHardwareDataType | awk '/Board Serial Number/ {print $4}')
model_number=$(sysctl -n hw.model)

# Get Board UUID
board_uuid=$(system_profiler SPHardwareDataType | awk '/Hardware UUID/ {print $3}')

# Output the gathered information
echo "Serial Number: $serial_number"
echo "MAC Address: $mac_address"
echo "Board Serial Number: $board_serial_number"
echo "Model Number: $model_number"
echo "Board UUID: $board_uuid"

echo "Make sure these values match those specified in values.conf"