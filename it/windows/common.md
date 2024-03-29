# Common notes for Windows

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Network](#network)
    - [route](#route)
    - [netstat](#netstat)
    - [netsh](#netsh)
- [CLI](#cli)
    - [Copying files](#copying-files)
    - [Check  files using](#check-files-using)
    - [RDP diagnostic](#rdp-diagnostic)
- [PowerShell](#powershell)
    - [Uninstall Windows 10’s Built-in Apps](#uninstall-windows-10’s-built-in-apps)
    - [Force remove language](#force-remove-language)
        - [Extra keyboard layout problem](#extra-keyboard-layout-problem)
- [Updates](#updates) 
    - [Disable auto update](#disable-auto-update) 
- [Other](#other)

<!-- /MarkdownTOC -->


## Network

### route

- `route.exe ADD –p 10.1.1.0 MASK 255.255.255.0 192.168.1.1 METRIC 1` - command to add static route for target IP `10.1.1.0/24`  through gateway `192.168.1.1`.
    ([source](http://help.telecom.by/faq/faq/routes/)).
    - `-p` - permanent (to prevent clearing added route after reboot)

### netstat

- `netstat -an | find "1234"` - check port `1234`


### netsh

- `netsh portproxy show all` - shows all port forwardings
- `netsh interface portproxy add v4tov4 listenaddress=127.0.0.1 listenport=8080 connectaddress=10.11.12.13 connectport=80` - enables forwarding
all IPv4-requests at 127.0.0.1:8080 to 10.11.12.13:80


## CLI

### Copying files

- `xcopy c:\source\file.txt c:\destination\newfile.txt*` - adds star after filename to indicate that it is file (not directory) name
and to prevent asking about object type ([source](http://stackoverflow.com/questions/4283312/batch-file-asks-for-file-or-folder))


### Check  files using

- `openfiles /local` - check status of support loca files
    - if `disabled` use `openfiles /local on` and `restart`
- `openfiles /query /fo table | find /I $path_to_file`


### RDP diagnostic

- `query session` - shows users and their RDP-sessions
- `query process /id <id>` - shows all process in RDP-session with `id = <id>`
(you can get `id` from `query session` result)


## PowerShell


### Uninstall Windows 10’s Built-in Apps

[source](https://www.howtogeek.com/224798/how-to-uninstall-windows-10s-built-in-apps-and-how-to-reinstall-them/)

To remove built-in apps by PowerShell you need use command `Remove-AppxPackage`.
Argument for this command can be obtained `Get-AppxPackage <name_template>`.

For example: `Get-AppxPackage <name_template> | Remove-AppxPackage`

Recommended name templates for some applications:

- `*3dbuilder*` - 3D Builder
- `*windowsalarms*` - Alarms and Clock
- `*windowscalculator*` - Calculator
- `*windowscommunicationsapps*` - Calendar and Mail
- `*windowscamera*` - Camera
- `*officehub*` - Get Office
- `*skypeapp*` - Get Skype
- `*getstarted*` - Get Started
- `*zunemusic*` - Groove Music
- `*windowsmaps*` - Maps
- `*solitairecollection*` - Microsoft Solitaire Collection
- `*bingfinance*` - Money
- `*zunevideo*` - Movies & TV
- `*bingnews*` - News
- `*onenote*`OneNote
- `*people*` - People
- `*windowsphone*` - Phone Companion
- `*photos*` - Photos
- `*windowsstore*` - Store
- `*bingsports*` - Sports
- `*xboxapp*` - Xbox
- `*soundrecorder*` - Voice Recorder
- `*bingweather*` - Weather


Cannot be removed:

- Contact Support
- Cortana
- Microsoft Edge
- Windows Feedback


### Force remove language

Step 1. Getting list of languages:
`Get-WinUserLanguageList`

Step 2. Remove language (you have to replace `<languagecode>` by LanguageTag from list of languages of Step 1)

```
$LangList = Get-WinUserLanguageList
$MarkedLang = $LangList | where LanguageTag -eq "<languagecode>"
$LangList.Remove($MarkedLang)

Set-WinUserLanguageList $LangList -Force
```

#### Extra keyboard layout problem

- Remove one of the key from registry branch `HKEY_USERS\.DEFAULT\Keyboard Layout\Preload` and reboot.
([source](https://answers.microsoft.com/en-us/windows/forum/windows_10-start-winpc/cant-remove-a-keyboard-layout-in-windows-10/058acf33-16d9-47f4-a24b-245b8823d90e))
    - `809` is for UK
    - `409` is for US
    - `419` is for Russian
- Add key `IgnoreRemoteKeyboardLayout` with value `1` into registry branch `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout`
([source](https://answers.microsoft.com/ru-ru/windows/forum/windows_10-other_settings-winpc/%D1%83%D0%B4%D0%B0%D0%BB%D0%B8%D1%82%D1%8C/4389627e-abb0-4c79-8498-b77c11ac214b))


## Updates

### Disable auto update

([source](https://pikabu.ru/story/kak_navsegda_otklyuchit_prinuditelnyie_obnovleniya_v_windows_10_4170820))

- Win10 Pro only
    - run `gpedit.msc`
    - `Конфигурация компьютера -> Административные шаблоны -> Компоненты Windows -> Центр обновления Windows -> Настройка автоматического обновления`
        - `Включено`
        - `5 - Разрешить локальному администратору выбирать параметры`
    - `Пуск -> параметры -> Обновления и безопасность -> Центр Обновления Windows`, `Проверить обновления`
- Windows 10 Home Edition
    - run `regedit`
    - x32
        - create section `WindowsUpdate\AU` in `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows` with parameter `AUOptions` with type `DWORD`
        - set `5` in `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\AUOptions`
    - x64 - repeat x32 for `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows` 
   


## Other

- `change port /query` - просмотр доступных портов (в том числе проброшенных через RDP)

 