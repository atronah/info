# Common notes for Unix

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [bash using](#bash-using)
    - [Get previos command with the same prefix](#get-previos-command-with-the-same-prefix)
    - [Get OS ID from os-release file](#get-os-id-from-os-release-file)
- [Commands](#commands)
- [sudo](#sudo)
    - [allow user use sudo](#allow-user-use-sudo)
    - [allow user use sudo without password](#allow-user-use-sudo-without-password)
    - [allow user to use sudo without password only for du and ping](#allow-user-to-use-sudo-without-password-only-for-du-and-ping)
- [Services](#services)
    - [services autorun](#services-autorun)
- [Networking](#networking)
    - [WiFi by NetworkManager \(CLI\)](#wifi-by-networkmanager-cli)
    - [disable IPv6](#disable-ipv6)
    - [TCP monitoring](#tcp-monitoring)
    - [Monitor TCP Traffic on specific port](#monitor-tcp-traffic-on-specific-port)
    - [add GRE protocol to firewalld rules to use pppd](#add-gre-protocol-to-firewalld-rules-to-use-pppd)
    - [Open port by iptables](#open-port-by-iptables)
    - [Open port by firewall-cmd](#open-port-by-firewall-cmd)
    - [Check ports listening](#check-ports-listening)
    - [Port forwarding](#port-forwarding)
    - [Get external ip](#get-external-ip)
- [Files](#files)
    - [fail2ban](#fail2ban)
- [Processes](#processes)
    - [get PID by process name](#get-pid-by-process-name)
- [SELinux](#selinux)
- [Gnome](#gnome)
    - [change Window's buttons layout](#change-windows-buttons-layout)
    - [show all apps in system tray](#show-all-apps-in-system-tray)
- [Locale, Keyboard layout](#locale-keyboard-layout)
- [Troubleshooting](#troubleshooting)
    - [process kswapd uses a lot of CPU](#process-kswapd-uses-a-lot-of-cpu)

<!-- /MarkdownTOC -->


## bash using

### Get previos command with the same prefix

edit `~/.inputrc` and add following lines:

```
# arrow up
"\e[A":history-search-backward
# arrow down
"\e[B":history-search-forward
```


### Get OS ID from os-release file

`echo $(. /etc/os-release; echo "$ID")`

Dot as command is equivalent to `source` command.


## Commands

- `type -a <command>` - display all locations containing an executable named `<command>`;


## sudo

Preferred way to edit `sudoers` (`/etc/sudoers`) is use command
`sudo visudo -f /etc/sudoers.d/my_override`.



### allow user use sudo

add line `username    ALL=(ALL)   ALL` into `sudoers` file.


### allow user use sudo without password

add line `username    ALL=(ALL)   NOPASSWD: ALL` into `sudoers` file.


### allow user to use sudo without password only for du and ping

add line `username ALL=(ALL) NOPASSWD:/usr/bin/du,/usr/bin/ping` into `sudoers` file.


## Services

### services autorun

```
systemctl is-enabled <service-name>
```

```
systemctl enable <service-name>
```


## Networking

### WiFi by NetworkManager (CLI)

- `nmcli radio wifi` - check wifi enabled
- `nmcli device wifi rescan` - rescan available wireless networks
- `nmcli device wifi list` - show available wireless networks
- `nmcli device wifi connect <SSID> password <password>` - connect to wireless network with SSID <SSID>
- `nmcli device set <DEVICE> autoconnect yes` - enable `autoconnect` feature for device `<DEVICE>`
(name of device can be obtained by `nmcli device`)


### disable IPv6

- `lsmod | grep ipv6` -- shows modules

[by sysctl](https://www.nbalonso.com/disable-ipv6-on-fedora-20/):

- `sysctl -a | grep ipv6 | less` - checks
- `sysctl -w net.ipv6.conf.all.disable_ipv6=1` - The easiest ways is to set the value with sysctl itself
- The second and a bit longer way is to write the change to /etc/sysctl.conf and then ask sysctl to read the config file. You can do it with:
```
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p
```

[by modprobe](http://linoxide.com/linux-how-to/disable-ipv6-centos-fedora-rhel/):

- `echo "install ipv6 /bin/true" >> /etc/modprobe.d/disable_ipv6.conf` - dummy install (need reboot after changes)



adds options into `/etc/sysconfig/network`

```
NETWORKING_IPV6=no
IPV6INIT=no
```

[see also](https://www.g-loaded.eu/2008/05/12/how-to-disable-ipv6-in-fedora-and-centos/)


### TCP monitoring

`tcpdump`


### Monitor TCP Traffic on specific port

[source](https://superuser.com/questions/604998/monitor-tcp-traffic-on-specific-port/848966#848966)

- `sudo iptables -I INPUT -p tcp --dport 443 --syn -j LOG --log-prefix "HTTPS SYN: "` and check syslog after it.
Note that the `LOG` target is a non-terminating target, which means that any rules following it will still be evaluated, and the packet will not be either rejected or accepted by the `LOG` rule itself. This makes the `LOG` target useful also for debugging firewall rules.


### add GRE protocol to firewalld rules to use pppd

see [firewalld article](./firewalld.md)


### Open port by iptables

```
iptables -I INPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT
service iptables save
```


### Open port by firewall-cmd

see [firewalld article](./firewalld.md)


### Check ports listening

```
lsof -i :3050
```

```
netstat -avp | grep 3050
```


### Port forwarding

command bellow forwards all TCP connections to local port `9999`
to remote port `5678` of remote address `1.2.3.4`
([source](https://unix.stackexchange.com/questions/10428/simple-way-to-create-a-tunnel-from-one-local-port-to-another#187038))

```
socat tcp-listen:9999,reuseaddr,fork tcp:1.2.3.4:5678
```


### Get external ip

from [source](https://unix.stackexchange.com/questions/22615/how-can-i-get-my-external-ip-address-in-a-shell-script):

- `dig @resolver1.opendns.com ANY myip.opendns.com +short`
(may be useful adding `alias wanip='dig @resolver1.opendns.com ANY myip.opendns.com +short'` into `bashrc` to use just `wanip` instead)
- `externalip dns`
- `curl -s l2.io/ip`
    - `http://whatismyip.akamai.com/` - the fastest using HTTP:
    - `https://4.ifcfg.me/` - the fastest using HTTPS with a valid cert
    - `http://ident.me/`
    - `http://curlmyip.com/`
    - `http://ifconfig.me/`


## Files

- `lsof -a -d 1-999 -c <command name>` - This will list all open files in the / directory,
which is everything on a linux filesystem.
Just tested and it shows only REG and DIR. For info by PID use option `-p <pid>` instead `-c`.
(from [serverfault.com](https://serverfault.com/questions/106398/lsof-restrict-output-to-physical-files-only-how))
- `lsof /path/to/file` - display all processes, which use file.
- `lsof -t /path/to/file | xargs kill` - kill all processes using file
- `lsof +L1` - shows used files which were deleted
- `fuser -m -u -v /path/to/file` - display all processes, which use file.
With key `-k` you can kill all this processes.
- renames multiple files by removing the extension:
    ```bash
    for i in *.tif; do mv -i $i `basename $i .tif`; done
    ```
- removes all 7z files except 6 newest
(`ls -1t` - one file per line and sorts by modification time, newest first;
`tail -n +7` - display lines starting from 7th line of input, i.e. skip first 6):
    ```bash
    for f in $(ls -1t *.7z | tail -n +7); do rm "$f"; done
    ```


### fail2ban

- `fail2ban-client status` - list of all jails
- `/var/log/fail2ban.log` - default log file
- `/var/log/secure` - default log file for `ssh-iptables` jail
- `fail2ban-client set ssh-iptables unbanip 111.222.333.444` - unban ip `111.222.333.444` for jail `ssh-iptables`
- `fail2ban-client -i` - enter to interactive mode
    - `status sshd` - shows status of sshd jail


## Processes

### get PID by process name

- `pgrep <process_name>`
- `ps -ef | awk '$8=="name_of_process" {print $2}'`
- `ps aux || awk 'NR==1 || /name_of_process/'`


## SELinux


- `getenforce` - get current SELinux status
    - `Disabled` - if non-active
    - `Enforced` - if active with enforced policies
    - `Permissive` - if active with non-permissive policies (only DAC)
- `sestatus` - check status of SELinux
- `setenforece [Enforcing | Permissive | 1 | 0]` - temporary enable/disable for the current session
- getting security context in format `user:role:type`
    - `ls -Z /path/to/file` - for file
    - `ps axZ | grep process` - for process
- logs
    - `/var/log/audit/audit.log` - if `auditd` is running
    - `/var/log/messages.log` - if `auditd` is not running, all messages are marked by `AVC`
    - `sealert -a /var/log/audit/audit.log > /path/to/mylogfile.txt` - generates human-readable log (`sealert` is a part of GUI tools)
- changing security context for files
    - `chcon -Rv --type=httpd_sys_content /html` - recursive changes type for /html folder from `default_t` to `httpd_sys_content` to allow access for `httpd`; these changes will work after reboot, but will be reset after changing labels of file systems.
    - `semanage fcontext -a -t httpd_sys_content_t "/html(/.*)?"` adds permanent rule to assign `httpd_sys_content` to all files which match pattern `/html(/.*)?`. It will work even after changing label of file systems.
    - `restorecon -v /var/www/html/index.html` - restores security context of file to default for that directory (to `httpd_sys_content`), it is useful after moving file (`mv`), because `mv` preserve source context (in contrast `cp` uses destination context).
    - `touch /.autorelabel && reboot` - reset labels/contexts for whole file systems. If it doesn't work (for example, after update distributive) you should use `genhomedircon` before `touch`



## Gnome

### change Window's buttons layout

- left-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close" ```
- right-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "close,minimize,maximize:menu"```


### show all apps in system tray

```
gsettings set com.canonical.Unity.Panel systray-whitelist "['all']"
```


## Locale, Keyboard layout

- `loadkeys <locale>` - temporary load locale for current session (for example `loadkeys us`)
- `/etc/X11/org.conf` or `/etc/X11/xorg.conf.d/00_keyboard.conf` - permanent changing locales
- `localectl` - utility to manage locales


## Troubleshooting

### process kswapd uses a lot of CPU

[source](https://blog.bozdaganian.com/2019/12/21/linux-pagecache-and-kswapd/)

kswapd - process wchish swaps modified pages out to the swap file.

- `echo 1 > /proc/sys/vm/drop_caches` (by `root` user) or `echo 1 | sudo tee /proc/sys/vm/drop_caches` (by `sudo`-user) - cleans cashes.
After that kswapd will have nothing to do. But, all used data should be re-cached and it can cause new perfomance problems.
- `echo vm.swappiness=0 >> /etc/sysctl.conf` - disables swap (in fact, the real effect of thar is more complicated than just disabling swap).

