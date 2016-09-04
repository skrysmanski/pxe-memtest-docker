# Run via: docker run -d --network=host -p 67:67/udp -p 69:69/udp -p 4011:4011/udp pxeboot

FROM alpine

# Make moreutils available; may not be required anymore once moreutils
# have been added to "main"
RUN echo @testing http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 && echo @testing http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN apk add --update moreutils@testing dnsmasq syslinux \
 && rm -rf /var/cache/apk/*

COPY files /

RUN ln -s /usr/share/syslinux/pxelinux.0 /tftpboot/ \
 && ln -s /usr/share/syslinux/ldlinux.c32 /tftpboot/

ENV PXE_INTERFACE eth0

# All ports are UDP ports
EXPOSE 67 69 4011

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

