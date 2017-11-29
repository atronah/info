
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
Argeument for this command can be obtained `Get-AppxPackage <name_template>`.

For example: `Get-AppxPackage <name_template> | Remove-AppxPackage`

Recomended name templates for some applications:

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




Other
=====
- `change port /query` - просмотр доступных портов (в том числе проброшенных через RDP)