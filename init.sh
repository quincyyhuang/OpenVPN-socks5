#!/usr/bin/env bash

while getopts u:p: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        p) password=${OPTARG};;
    esac
done

if [ -z "$username" ] || [ -z "$password" ]
then
    openvpn --setenv PATH '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' --script-security 2 --up /etc/openvpn/tun-up.sh --down /etc/openvpn/update-resolv-conf.sh --down-pre --config /etc/openvpn/vpn.ovpn
else
    echo -ne "$username\n$password" >> /etc/openvpn/auth.txt
    openvpn --setenv PATH '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' --script-security 2 --up /etc/openvpn/tun-up.sh --down /etc/openvpn/update-resolv-conf.sh --down-pre --config /etc/openvpn/vpn.ovpn --auth-user-pass /etc/openvpn/auth.txt
fi
