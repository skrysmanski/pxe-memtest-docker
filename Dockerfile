# Run via: docker run -d --network=host -p 67:67/udp -p 69:69/udp -p 4011:4011/udp pxeboot

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y dnsmasq pxelinux syslinux-common

COPY files /

RUN ln -s /usr/lib/syslinux/modules/bios/ldlinux.c32 /tftpboot/ \
 && ln -s /usr/lib/PXELINUX/pxelinux.0 /tftpboot/

ENV PXE_DHCP_SUBNET 192.168.178.0

# All ports are UDP ports
EXPOSE 67 69 4011

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
