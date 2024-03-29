# SSH

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Authentification by key \(without password\)](#authentification-by-key-without-password)
    - [Common](#common)
    - [From unix](#from-unix)
    - [From windows](#from-windows)
- [Forwarding ports](#forwarding-ports)
    - [From remote to local](#from-remote-to-local)
    - [Use ssh_config](#use-ssh_config)
    - [Permanent ssh](#permanent-ssh)
- [Sharing internet through ssh](#sharing-internet-through-ssh)
    - [Initial](#initial)
    - [Seting up](#seting-up)
- [Links](#links)

<!-- /MarkdownTOC -->


## Authentification by key (without password)

To disable password authentification add into `/etc/ssh/sshd_config` follow line:

```bash
Match User atronah
    PasswordAuthentication no
```

### Common

Create `authorized_keys` file:
- `mkdir ~/.ssh`
- `chmod 0700 ~/.ssh`
- `touch ~/.ssh/authorized_keys`
- `chmod 0644 ~/.ssh/authorized_keys`


### From unix

- `ssh-keygen` - generate ssh key pair (publick and private keys)
- `ssh-copy-id user@server` - copy your public ssh key into `/home/user/.ssh/authorized_keys` file on server
- `ssh-copy-id "user@server -p 2222"` - use `ssh-copy-id` with additional ssh options, etc port number


### From windows

- use `puttygen.exe` app from `PuTTY`-tools to generate RSA key pair:
private (`.ppk`-file) and public (`.pub` or any other).
- copy your public key (`.pub` file) to remote host, for example, by WinSCP
- add your public key into `authorized_keys` file by command:
`ssh-keygen -i -f my_public_key.pub >> ~/.ssh/authorized_keys`
- connect to remote host with your user
(if you use non-root user, either specify `Connection/Data/Auto-login username` or add `username@` before host name)



## Forwarding ports

### From remote to local

- `ssh -R bind_address:remote_port:host:port user@remote_host` - forward all packets
to `bind_address:remote_port` on `remote_host` side to `host:port` on local size.

Notes from [superuser.com](https://superuser.com/questions/588591/how-to-make-ssh-tunnel-open-to-public):

- `ssh -R \*:8080:localhost:80 -N root@example.com` - binds to all interfaces individually
- `ssh -R 0.0.0.0:8080:localhost:80 -N root@example.com` - creates a general IPv4-only bind, which means that the port is accessible on all interfaces via IPv4.
- `ssh -R "[::]:8080:localhost:80" -N root@example.com` - probably technically equivalent to the first, but again it creates only a single bind to ::,
which means that the port is accessible via IPv6 natively and via IPv4 through IPv4-mapped IPv6 addresses (doesn't work on Windows, OpenBSD).
(You need the quotes because [::] could be interpreted as a glob otherwise.)

about not-lo `bind_address`:

> Note that if you use OpenSSH sshd server, the server's `GatewayPorts` option needs to be enabled
> (set to yes or clientspecified) for this to work (check file `/etc/ssh/sshd_config` on the server).
> Otherwise (default value for this option is no), the server will always force the port to be bound on the loopback interface only.


### Use ssh_config

If you want to forward port every time when you connect to host `my_host`,
you can describe it in `ssh_config` file:

```
Host my_host
        HostName=my_host.ru
        Port=2222
        User=user
        RemoteForward *:30080 127.0.0.1:80
        RemoteForward *:30081 127.0.0.1:81
        ServerAliveInterval 30
        ServerAliveCountMax 3
        StrictHostKeyChecking no
```

### Permanent ssh

to prevent losing connection you can use `autossh` utility,
which monitoring connection and reconnect if it need

```
autossh -M 20000 -f -N my_host
```


## Sharing internet through ssh

[source](https://serverfault.com/questions/950352/share-internet-from-windows-machine-to-a-linux-machine-through-ssh)

### Initial

- `noinet_server` - unix server without access to the internet
- `proxy_server:8888` - http proxy server (I used [3proxy](../apps/3proxy.md) on aws ec2)
- `inet_server` - unix/win machine with access to the internet and with ssh access to `noinet_server`


### Seting up

connect `inet_server` from to `noinet_server`
with tunneling all requests to its `127.0.0.1:8080` to `proxy_server:8888`:

```
[inet_server]$ ssh -R 8080:proxy_server:8888 user@noinet_server
```

check that we have no access to the internet from `noinet_server`
```
[noinet_server]$ curl -vv http://serverfault.com
```

set enviroments to enable using http/https proxy with using `user` and `password`
(remember, we use ssh tunnel `127.0.0.1:8080 -> proxy_server:8888`):

```
export http_proxy="http://user:password@127.0.0.1:8080"
export https_proxy=$http_proxy
```

check that we have got access to the internet from `noinet_server`
```
[noinet_server]$ curl -vv http://serverfault.com
```


to make yum using it add following lines to `/etc/yum.conf`

```
proxy=http://user:password@127.0.0.1:8080
proxy_username=user
proxy_password=password
```


# Links

- [How to setup ssh tunnel to forward ssh?](https://serverfault.com/questions/33283/how-to-setup-ssh-tunnel-to-forward-ssh)
