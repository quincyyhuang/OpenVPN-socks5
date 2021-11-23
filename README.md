# OpenVPN-socks5

[Docker Hub](https://hub.docker.com/repository/docker/quincyhuang/openvpn-socks5/)

A tun2socks docker image for OpenVPN.

# Features

This project uses [Dante](https://www.inet.no/dante/) SOCKS server which implements RFC 1928 and related standards.

- TCP connect
- TCP bind
- UDP associate

# Usage

Change `/path/to/vpn.ovpn` to the **ABSOLUTE PATH** of your real ovpn config file.

## With credentials passed in as arguments

```bash
docker run \
  --rm -d --cap-add=NET_ADMIN --device=/dev/net/tun \
  -p 1080:1080/tcp -p 1080:1080/udp \
  -v /path/to/vpn.ovpn:/etc/openvpn/vpn.ovpn \
  quincyhuang/openvpn-socks5 \
  -u [username] -p [password]
```

## Prompt for credentials

```bash
docker run \
  --rm -it --cap-add=NET_ADMIN --device=/dev/net/tun \
  -p 1080:1080/tcp -p 1080:1080/udp \
  -v /path/to/vpn.ovpn:/etc/openvpn/vpn.ovpn \
  quincyhuang/openvpn-socks5
```

When done entering credentials, hit `Ctrl-p` and `Ctrl-q` in sequence to detach the console.

# Build locally

```bash
docker build -t openvpn-socks5 .
```
