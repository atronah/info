# Common notes for MacOS

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Tips](#tips)
    - [List all hardware network ports](#list-all-hardware-network-ports)
    - [TFTP server](#tftp-server)
    - [Move/drag window by clicling within it](#movedrag-window-by-clicling-within-it)
    - [Touch ID for sudo in cli](#touch-id-for-sudo-in-cli)

<!-- /MarkdownTOC -->

## Tips


### List all hardware network ports

[source](https://help.keenetic.com/hc/ru/articles/360018503800)


```
networksetup -listallhardwareports
```

### TFTP server

[source](https://help.keenetic.com/hc/ru/articles/360018503800)

to start
```
sudo launchctl load -F /System/Library/LaunchDaemons/tftp.plist
```

to stop

```
sudo launchctl unload -F /System/Library/LaunchDaemons/tftp.plist
```

folder to place files for booting by TFTP: `/private/tftpboot`

### Move/drag window by clicling within it

([source](https://superuser.com/a/1466919),
[source2](http://www.mackungfu.org/UsabilityhackClickdraganywhereinmacOSwindowstomovethem))


Run this command in terminal to enable Ctrl + Cmd + Click in any window to move. Restart after.
```
# to add
defaults write -g NSWindowShouldDragOnGesture -bool true
```

Run this command in terminal to remove this functionality. Restart after.
```
# to remove
defaults delete -g NSWindowShouldDragOnGesture
```


### Touch ID for sudo in cli

- disable `System Integrity Protection`
    - shut down macbook
    - press Power/TouchId button and hold until appearing load options
    - choose Options, choose User and entet password, open Terminal from main menu
    - enter command `csrutil status` to check status
    - enter command `csrutil disable` to disable protection
    - restart
- enable root user
    - open `System Preferences`
    - open `User & Groups`
    - unlock it
    - click on button `Join...` near `Network Account Server`
    - click on button `Open Directory Utility...`
    - unlock it
    - choose `Enalbe Root User` in `Edit` section of main menu
    - enter password
- open Terminal
- backup file `/etc/pam.d/sudo`
- switch to root user by command `su root` and enter password
- add add at the beginning of file `/etc/pam.d/sudo` this line
    ```
    auth       sufficient     pam_tid.so
    ```
- save changes in `/etc/pam.d/sudo`
- exit from root user 
- disable root user
- reboot in Recovery Mode and enable `System Integrity Protection` by command `csrutil disable`
- restart
