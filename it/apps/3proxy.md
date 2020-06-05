[source](https://medium.com/@nzvtrkk/настройка-socks5-proxy-на-amazon-ec2-512dbdb086da)

## Install

install reuqired pakages

```
sudo apt-get update
sudo apt-get install build-essential libevent-dev libssl-dev
```

dounload and unpack 3proxy sources

```
cd /usr/src
sudo wget http://3proxy.ru/0.6.1/3proxy-0.6.1.tgz
sudo tar zxvf 3proxy-0.6.1.tgz
```

change working directory to folder with 3proxy sources

```
cd 3proxy-0.6.1
```

to make the server anonymous, edit proxy.h before compilation

```
sudo nano src/proxy.h
```

add line to section `define`:

```
#define ANONYMOUS 1
```

make and install:

```
sudo make -f Makefile.Linux
sudo make -f Makefile.Linux install
```


## Run

create directory with config of our proxy server

```
mkdir -p ~/3proxy
cd ~/3proxy
nano 3proxy.cfg
```

content of 3proxy.cfg

```
# run as a service
daemon
# no logging
log /dev/null
# allow all ports
allow * * * *
# auth by login and password
# instaed `username` and `password` write your credential
auth strong
users username:CL:password
# DNS servers
nserver 8.8.8.8
nserver 77.88.8.8
nserver 127.0.0.1
# DNS cache
nscache 65536
# http proxy by default uses port 4545
proxy -p4545 -n -a
# socks proxy by default uses port 2323
socks -p2323
```


All DNS servers copy from `/etc/resolv.conf` (just chnage `nameserver` to `nserver`),
see content of that file by nano:

```
nano /etc/resolv.conf
```


Run proxy-server

```
3proxy ~/3proxy/3proxy.cfg
```

Check listening ports:

```
netstat -an | grep -i listen
```