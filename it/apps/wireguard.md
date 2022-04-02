# WireGuard vpn

based on [instruction](https://t.me/t0digital/32) from [t0digital](https://t.me/t0digital)


## Install on CentOS

```bash
yum install epel-release elrepo-release
yum install yum-plugin-elrepo
yum install kmod-wireguard wireguard-tools
yum install qrencode
```


## Enable IPv4 port forwarding

```bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/01-user-sysctl.conf
sysctl -p
systemctl restart sysctld
```


## Setup server side

generate key pair for server

```bash
wg genkey | tee /etc/wireguard/wg0_privatekey | wg pubkey | tee /etc/wireguard/wg0_publickey
chmod 600 /etc/wireguard/wg0_privatekey
```

and for client
```bash
wg genkey | tee /etc/wireguard/guest_privatekey | wg pubkey | tee /etc/wireguard/guest_publickey
chmod 600 /etc/wireguard/guest_publickey
```


create server configuration file

```bash
vim /etc/wireguard/wg0.conf
```

with follow content 

```
[Interface]
PrivateKey = <wg0_privatekey>
Address = 10.0.0.1/24
ListenPort = 51899
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUER

[Peer]
# guest
PublicKey = <guest_publickey>
AllowedIPs = 10.0.0.2/32
```

in that config you should

- replace `<wg0_privatekey>` by content of `/etc/wireguard/wg0_privatekey` file 
- replace `eth0` by your network interface name
- set you port instead of `51899`
- set different IP for each pear (`10.0.0.2/32` in an example)


## Setup client side

create config for client

```bash
vim /etc/wireguard/guest.conf
```


with foloow content:

```
[Interface]
PrivateKey = <guest_privatekey>
Address = 10.0.0.2/32
DNS = 1.1.1.1

[Peer]
PublicKey = <wg0_publickey>
Endpoint = 99.88.77.66:51899
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 20
```

in that config you should

- replace `<guest_privatekey>` by content of `/etc/wireguard/guest_privatekey` file 
- replace `<wg0_publickey>` by content of `/etc/wireguard/wg0_publickey` file 
- replace `eth0` by your network interface name
- set up IP which you assign to that peer on server side (`10.0.0.2/32` in an example)
- check or set up DNS
- set up server port and IP you port (instead of `99.88.77.66:51899`)


## Enable and start service

```bash
systemctl enable wg-quick@wg0.service
systemctl start wg-quick@wg0.service
systemctl status wg-quick@wg0.service
```

## Generate QR-code with config info to fast setup

```bash
qrencode -t ansiutf8 < /etc/wireguard/guest.conf
```
