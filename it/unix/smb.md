# Samba

## server

### no password access

example of `/etc/samba/smb.cond`:

```
[global]
	# ... other options ...
	#
	security = user
	# Bad User - map unexisted login user to guest account
	map to guest = Bad User
	# Use smbpublic user as guest account
	guest account = smbpublic

[public]
	comment = Public directory
	path = /home/smbpublic/
	browsable = yes
	read only = yes
	guest ok = yes
```


### SELinux

Allow access to shared folder in SELinux

```
chcon -R -t samba_share_t /my_sharing_folder
```


### firewalld

Allow samba protocol in Firewall

```
firewall-cmd --zone=public --permanent --add-service=samba
firewall-cmd --reload
```


## client

### copy to samba share folder by smbclient

`smbclient \\host\\sharename -A auth.info -c "put src_folder/src_file to_folder\\$dst_file_name"`

where `auth.info` is file which contains authentication information like that:

```
USERNAME=atronah
PASSWORD=qwerty
DOMAIN=WORKGROUP
```


### mount samba
info from [ubuntu.com](https://wiki.ubuntu.com/MountWindowsSharesPermanently)

- Mounting unprotected (guest) network folders:
`//servername/sharename  /media/windowsshare  cifs  guest,uid=1000,iocharset=utf8  0  0`
- Mount password protected network folders:
`//servername/sharename  /media/windowsshare  cifs  username=msusername,password=mspassword,iocharset=utf8,sec=ntlm  0 0`
- Mount password protected network folders with use credentials file:
`//servername/sharename /media/windowsshare cifs credentials=/home/user/.smbcredentials,iocharset=utf8,sec=ntlm 0 0`
where `.smbcredentials` has `0600` permisions and contains 2 lines: `username=msusername` and `password=msuserpassword`


## links

- [Setting Up Samba](https://www.tecmint.com/setup-samba-file-sharing-for-linux-windows-clients/)