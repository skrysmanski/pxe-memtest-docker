#!/bin/sh -e

PXE_DHCP_SUBNET="$(ifdata -pN $PXE_INTERFACE)"

exec /usr/sbin/dnsmasq -d \
  --interface=$PXE_INTERFACE \
  --dhcp-range=$PXE_DHCP_SUBNET,proxy

