#!/bin/bash
set -e

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

# NAT masquerading
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
