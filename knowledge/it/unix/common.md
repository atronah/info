Commands
--------
- `type -a <command>` - display all locations containing an executable named `<command>`;
- `fuser -m -u -v /path/to/file` - display all processes, which use file. 
With key `-k` you can kill all this processes.


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


### TCP monitoring

```tcpdump```


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


Processes
---------

### get PID by process name
- `pgrep <process_name>` 
- `ps -ef | awk '$8=="name_of_process" {print $2}'`


SELinux
-------

### enable access for smb
```chcon -R -t samba_share_t /my_sharing_folder```


Gnome
------

### change Window's buttons layout
- left-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close" ```
- right-side: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "close,minimize,maximize:menu"```


### show all apps in system tray
```
gsettings set com.canonical.Unity.Panel systray-whitelist "['all']"
```


Samba
-----

### copy to samba share folder by smbclient

`smbclient \\host\\sharename -A auth.info -c "put src_folder/src_file to_folder\\$dst_file_name"`

where `auth.info` is file which contains authentication information like that:

```
USERNAME=atronah
PASSWORD=qwerty
DOMAIN=WORKGROUP
```