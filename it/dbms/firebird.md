# Firebird

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [backup/restore with stdout/stdin \(without a dump file\)](#backuprestore-with-stdoutstdin-without-a-dump-file)
- [Encoding](#encoding)
    - [String Constants in Hexadecimal Notation](#string-constants-in-hexadecimal-notation)
- [Garbage Collecting \(sweep\)](#garbage-collecting-sweep)
- [Convert RedDatabase 2.5 to Firebird 3.0](#convert-reddatabase-25-to-firebird-30)
- [Install on unix](#install-on-unix)
    - [install support package xinetd](#install-support-package-xinetd)
    - [install firebird server classic instance](#install-firebird-server-classic-instance)
    - [recomended setups](#recomended-setups)
    - [xinetd conf](#xinetd-conf)
    - [after install](#after-install)

<!-- /MarkdownTOC -->

## backup/restore with stdout/stdin (without a dump file)

backup direct into archive (usefull for huge databases):

```bash
gbak -b -g -v MY_DB stdout | 7z a -si MY_DB_BACKUP.7z
```

clone database through backup/restore without a dump file:

```
gbak -b MY_DB stdout | gbak -rep stdin MY_DB_COPY
```

## Encoding

### String Constants in Hexadecimal Notation

Example:

```sql
select 'first line' || x'0d0a' || 'second line' from rdb$database
```

But, be careful with encoding,
because as says [official documentation](https://firebirdsql.org/file/documentation/reference_manuals/fblangref25-en/html/fblangref25-commons-expressions.html):

> Strings entered this way will have character set OCTETS by default but the introducer syntax can be used to force a string to be interpreted as another character set.
To prevent encoding troubles
recomends using introducer syntax to explicit specifying encoding:

Therefore, it would be more correct to use the following query (for utf8 strings):

```sql
select 'first line' || _utf8 x'0d0a' || 'second line' from rdb$database
```




## Garbage Collecting (sweep)

Garbage collecting, also known as sweep, is removing no longer required versions of records
(versions of records are considered as no longer required when there is no active transaction, which need it).

Garbage collecting usualy happens during regular reading (eg `select`)
and manual sweep works as `select`-query from all tables in dataabase.

There are 4 counters about transactions:

- Oldest transaction
- Oldest active
- Oldest snapshot
- Next transaction

In defaults forced garbage collecting runs every time, when difference between `Oldest transaction` and `Oldest active` is more then `20000` (default `sweep interval`).
After that `Oldest transaction` moves to `Oldest active`.

If there is no active transaction in database, all transaction counters moves to `Next transaction`.


For example (from real tesing), there is database with the following counters:

- Oldest transaction: 4500
- Oldest active: 5500
- Oldest snapshot: 5500
- Next transaction: 6500

After manual sweep counters became:

- Oldest transaction: 5500
- Oldest active: 5500
- Oldest snapshot: 5500
- Next transaction: 6500

After disconnect all by `gfix -shut -force 0` and manual sweep counters became:

- Oldest transaction: 6500
- Oldest active: 6500
- Oldest snapshot: 6500
- Next transaction: 6500


To manual garbage collecting use
```
gfix -user <USER> -pas <PASSWORD> -sweep <database_path_or_alias>
```



## Convert RedDatabase 2.5 to Firebird 3.0

To restore backup which was made on RedDatabase 2.5 on Firebird 3.0 you should remove all unsupported user privileges from system table `RDB$USER_PRIVILEGES`
(and you can do it only from connection to RedDatabase, i.e. before backuping).

`delete from RDB$USER_PRIVILEGES where RDB$OBJECT_TYPE > 13`

if you can connect to source rdb-database, you can do backup with gbak from Firebird 3.0.
if you have only backup, to you can try restore it to Firebird 2.5 (that version ignore unsupported types) and after that backup it by gbak from Firebird 3.0 and restore to Firebird 3.0.


## Install on unix
### install support package xinetd

- `dnf install xinetd`

### install firebird server classic instance

- `dnf install firebird-classic` - install on RedHat
- `apt-get install firebird2.5-classic` - install on Debian


### recomended setups

(from chat with [red-soft](red-soft.ru) developers)

- disable `huge transparent pages`
(e.g. write `echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled` into `/etc/rc.local`
- file system for ssd: `noatime,discard,nobarrier`
    - hdd without `nodiscard` too
    - `nobarrier` rewuired for ext4


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