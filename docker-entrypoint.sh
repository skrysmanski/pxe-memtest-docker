#!/bin/bash
set -e

exec /usr/sbin/dnsmasq -d --dhcp-range=$PXE_DHCP_SUBNET,proxy

