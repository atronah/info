
Forwarding ports
----------------

### From remote to local

- `ssh -R bind_address:remote_port:host:port user@remote_host` - forward all packets to `bind_address:remote_port` on `remote_host` side to `host:port` on local size.

Notes from [superuser.com](https://superuser.com/questions/588591/how-to-make-ssh-tunnel-open-to-public):
- `ssh -R \*:8080:localhost:80 -N root@example.com` - binds to all interfaces individually
- `ssh -R 0.0.0.0:8080:localhost:80 -N root@example.com` - creates a general IPv4-only bind, which means that the port is accessible on all interfaces via IPv4. 
- `ssh -R "[::]:8080:localhost:80" -N root@example.com` - probably technically equivalent to the first, but again it creates only a single bind to ::, 
which means that the port is accessible via IPv6 natively and via IPv4 through IPv4-mapped IPv6 addresses (doesn't work on Windows, OpenBSD).  
(You need the quotes because [::] could be interpreted as a glob otherwise.)

about not-lo `bind_address`:
> Note that if you use OpenSSH sshd server, the server's `GatewayPorts` option needs to be enabled 
> (set to yes or clientspecified) for this to work (check file `/etc/ssh/sshd_config` on the server). 
> Otherwise (default value for this option is no), the server will always force the port to be bound on the loopback interface only.Links


Links
=====
- [How to setup ssh tunnel to forward ssh?](https://serverfault.com/questions/33283/how-to-setup-ssh-tunnel-to-forward-ssh)