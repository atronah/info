smbclient
---------

### copy to samba share folder
`smbclient \\host\\sharename -A auth.info -c "put src_folder/src_file to_folder\\$dst_file_name"`

where `auth.info` is file which contains authentication information like that:

```
USERNAME=atronah
PASSWORD=qwerty
DOMAIN=WORKGROUP
```