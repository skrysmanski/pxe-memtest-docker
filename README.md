# PXE server booting memtest86+ in a Docker container
This repo provides an example implementation of a PXE server (via `dnsmasq`) that boots memtest86+. The server runs as proxyDHCP (i.e. it can be used alongside an existing DHCP server).

**Note:** To get started quickly, it's recommended to run the container on the host network. It runs fine within a virtual machine as long as the vm's network is a bridged network (and no NAT). Currently, this container **doesn't work in Docker for Mac or Docker for Windows**.

For more details on this example, see: https://manski.net/2016/09/pxe-server-on-existing-network-dhcp-proxy-on-ubuntu/

## Running the container
There are two easy ways to run this container.

1. **GitHub:** Clone this repository and execute `docker-compose up`.
2. **Docker Hub:** Put the `docker-compose.yml` from below in a directory and then execute `docker-compose up`.

**Note:** By default, the service provides PXE on network interface `eth0`. If you need/have a different interface, you'll need to put its name into the environment variable `PXE_INTERFACE`.

### docker-compose.yml for Docker Hub
```yml
version: '2'
services:
  pxe-memtest:
    image: skrysmanski/pxe-memtest
    environment:
      - PXE_INTERFACE=eth0
    ports:
      - "67:67/udp"
      - "69:69/udp"
      - "4011:4011/udp"
    network_mode: "host"
```

## Extending this container
This container is primarily just an example to get one started with PXE. For a more customizable and powerful version, use the [docker-ipxe-server](https://github.com/skrysmanski/docker-ipxe-server) repository instead.
