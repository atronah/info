Classic Server
==============

Install on unix
---------------
### install support package xinetd

- `dnf install xinetd`

### install firebird server classic instance

- `dnf install firebird-classic` - install on RedHat
- `apt-get install firebird2.5-classic` - install on Debian

### xinetd conf

sometimes, firebird package doesn't install config file for `xinetd` with itslef.
default conf file (`/etc/xinetd.d/firebirg`) contains:

```
# default: on
# description: FirebirdSQL server
#
# Be careful when commenting out entries in this file. Active key entry should
# be the first as some scripts (CSchangeRunUser.sh in particular) use sed 
# scripting to modify it.

service gds_db
{
	disable = no
	flags		= REUSE
	socket_type	= stream
	wait		= no
	user		= firebird
# These lines cause problems with Windows XP SP2 clients
# using default firewall configuration (SF#1065511)
#	log_on_success	+= USERID
#	log_on_failure	+= USERID
	server		= /usr/sbin/fb_inet_server
}
```

But, there are corrected file from [GitHub Gist](https://gist.github.com/mariuz/11372182):
```
# default: on
# description: FirebirdSQL classic server, v2.5
#
# firebird2.5-classic uses /etc/xinet.d/firebird2.5 by default

service gds_db
{
        bind                    = 127.0.0.1
        disable                 = no
        flags                   = REUSE NODELAY
        socket_type             = stream
        wait                    = no
        user                    = firebird
        log_on_success          += USERID
        log_on_failure          += USERID
        instances               = UNLIMITED
        per_source              = UNLIMITED
        server                  = /usr/sbin/fb_inet_server
}
```

Notes:
- to enable remote access, comment `bind 127.0.0.1` line or change ip from `127.0.0.1` to `0.0.0.0`. Maybe it is unnecessary.
- with used `log_on_success` and `log_on_failure` you can have trouble with slowly connections from Windows clients. 
That's why I recomend comment it.

### after install
- open 3050 port: 
    - in `firebird.conf` (`/etc/firebird/firebird.conf`): uncommet `RemoteServicePort=3050` line
    - in firewall:
        - firewalld: `firewall-cmd --zone=FedoraServer --permanent --add-port=3050/tcp && firewall-cmd --reload`)
        - iptables: `iptables -I INPUT -p tcp --dport 3050 -m state --state NEW -j ACCEPT && service iptable save`
- restart `xinetd` daemon (i.e. `systemctl restart xinetd`)