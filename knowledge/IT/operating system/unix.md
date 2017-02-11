Автозапуск:
```systemctl is-enabled <service-name>```
```systemctl enable <service-name>```

Лог подключений
```journalctl -f```


SELinux enable access for smb
```chcon -R -t samba_share_t /my_sharing_folder```


Отслеживание tcp трафика:```tcpdump```

Добавление GRE протокола в правила файрвола для работы pppd
```
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv6 filter INPUT 0 -p gre -j ACCEPT
firewall-cmd --reload
```


GNOME
------

Расположение кнопок управления окном (свернуть, закрыть).
- справа: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close" ```
- слева: ```gconftool-2 --set /apps/metacity/general/button_layout --type string "close,minimize,maximize:menu"```


Отобразить все значки в трее
```
gsettings set com.canonical.Unity.Panel systray-whitelist "['all']"
```