bash using
----------

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


Commands
--------

- `type -a <command>` - display all locations containing an executable named `<command>`;


sudo
----

Preferred way to edit `sudoers` (`/etc/sudoers`) is use command
`sudo visudo -f /etc/sudoers.d/my_override`.



### allow user use sudo

add line `username    ALL=(ALL)   ALL` into `sudoers` file.

### allow user use sudo without password

add line `username    ALL=(ALL)   NOPASSWD: ALL` into `sudoers` file.


Services
--------

### services autorun
```systemctl is-enabled <service-name>```
```systemctl enable <service-name>```


Networking
----------

### WiFi by NetworkManager (CLI)

- `nmcli radio wifi` - check wifi enabled 
- `nmcli device wifi rescan` - rescan available wireless networks 
- `nmcli device wifi list` - show available wireless networks
- `nmcli device wifi connect <SSID> password <password>` - connect to wireless network with SSID <SSID>

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


### add GRE protocol to firewalld rules to use pppd

```
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv6 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --reload
```

### Open port by iptables
```
iptables -I INPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT
service iptables save
```

### Open port by firewall-cmd
```
firewall-cmd --zone=FedoraServer --permanent --add-port=3050/tcp
firewall-cmd --reload
firewall-cmd --info-zone=FedoraServer
```


### Check ports listening
```
lsof -i :3050
```

```
netstat -avp | grep 3050
```


Files
-----
- `lsof -a -d 1-999 -c <command name>` - This will list all open files in the / directory,
which is everything on a linux filesystem.
Just tested and it shows only REG and DIR. For info by PID use option `-p <pid>` instead `-c`.
(from [serverfault.com](https://serverfault.com/questions/106398/lsof-restrict-output-to-physical-files-only-how))
- `lsof /path/to/file` - display all processes, which use file.
- `lsof -t /path/to/file | xargs kill` - kill all processes using file
- `lsof +L1` - shows used files which were deleted
- `fuser -m -u -v /path/to/file` - display all processes, which use file.
With key `-k` you can kill all this processes.

renames multiple files by removing the extension:

```
for i in *.tif; do mv -i $i `basename $i .tif`; done
```


Processes
---------

### get PID by process name
- `pgrep <process_name>` 
- `ps -ef | awk '$8=="name_of_process" {print $2}'`


SELinux
-------



Gnome
------

### change Window's buttons layout
- left-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close" ```
- right-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "close,minimize,maximize:menu"```


### show all apps in system tray
```
gsettings set com.canonical.Unity.Panel systray-whitelist "['all']"
```


Locale, Keyboard layout
-----------------------

- `loadkeys <locale>` - temporary load locale for current session (for example `loadkeys us`)
- `/etc/X11/org.conf` or `/etc/X11/xorg.conf.d/00_keyboard.conf` - permanent changing locales
- `localectl` - utility to manage locales
