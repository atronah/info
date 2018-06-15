Network
=======

## route

- `route.exe ADD –p 10.1.1.0 MASK 255.255.255.0 192.168.1.1 METRIC 1` - command to add static route for target IP `10.1.1.0/24`  through gateway `192.168.1.1`.
    ([source](http://help.telecom.by/faq/faq/routes/)).
    - `-p` - permanent (to prevent clearing added route after reboot)

## netstat

- `netstat -an | find "1234"` - check port `1234`


CLI
===

Copying files
-------------

- `xcopy c:\source\file.txt c:\destination\newfile.txt*` - adds star after filename to indicate that it is file (not directory) name
and to prevent asking about object type ([source](http://stackoverflow.com/questions/4283312/batch-file-asks-for-file-or-folder))


PowerShell
==========


Uninstall Windows 10’s Built-in Apps
------------------------------------

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


## Force remove language

Step 1. Getting list of languages:
`Get-WinUserLanguageList`

Step 2. Remove language (you have to replace `<languagecode>` by LanguageTag from list of languages of Step 1)

```
$LangList = Get-WinUserLanguageList
$MarkedLang = $LangList | where LanguageTag -eq "<languagecode>"
$LangList.Remove($MarkedLang)

Set-WinUserLanguageList $LangList -Force
```

### Extra keyboard layout problem

- Remove one of the key from registry branch `HKEY_USERS\.DEFAULT\Keyboard Layout\Preload` and reboot.
([source](https://answers.microsoft.com/en-us/windows/forum/windows_10-start-winpc/cant-remove-a-keyboard-layout-in-windows-10/058acf33-16d9-47f4-a24b-245b8823d90e))
    - `809` is for UK
    - `409` is for US
    - `419` is for Russian
- Add key `IgnoreRemoteKeyboardLayout` with value `1` into registry branch `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout`
([source](https://answers.microsoft.com/ru-ru/windows/forum/windows_10-other_settings-winpc/%D1%83%D0%B4%D0%B0%D0%BB%D0%B8%D1%82%D1%8C/4389627e-abb0-4c79-8498-b77c11ac214b))



Other
=====
- `change port /query` - просмотр доступных портов (в том числе проброшенных через RDP)