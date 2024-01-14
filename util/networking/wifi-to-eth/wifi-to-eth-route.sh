#!/bin/bash

# Share Wifi with Eth device
#
#
# This script is created to work with Raspbian Stretch
# but it can be used with most of the distributions
# by making few changes.
#
# Make sure you have already installed `dnsmasq`
# Please modify the variables according to your need
# Don't forget to change the name of network interface
# Check them with `ifconfig`

ip_address_and_network_mask_in_CDIR_notation="192.168.2.1/24"
dhcp_range_start="192.168.2.2"
dhcp_range_end="192.168.2.100"
dhcp_time="12h"
dns_server="1.1.1.1"
eth="eth0"
wlan="wlan0"

if [[ $EUID -ne 0 ]]; then
	echo "This script should be run with root/sudo privileges."
	exit 1
fi

systemctl start network-online.target &> /dev/null

iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -o $wlan -j MASQUERADE
iptables -A FORWARD -i $wlan -o $eth -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $eth -o $wlan -j ACCEPT

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

ip link set $eth down
ip link set $eth up
ip addr add  $ip_address_and_network_mask_in_CDIR_notation dev $eth 

# Remove default route created by dhcpcd
ip route del 0/0 dev $eth &> /dev/null

systemctl stop dnsmasq

rm -rf /etc/dnsmasq.d/* &> /dev/null

echo -e "interface=$eth
bind-interfaces
server=$dns_server
domain-needed
bogus-priv
dhcp-range=$dhcp_range_start,$dhcp_range_end,$dhcp_time" > /tmp/custom-dnsmasq.conf

cp /tmp/custom-dnsmasq.conf /etc/dnsmasq.d/custom-dnsmasq.conf
systemctl start dnsmasq