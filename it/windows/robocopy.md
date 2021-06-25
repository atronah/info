# ROBOCOPY

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [arguments](#arguments)
- [examples](#examples)
    - [copy old logs to archive folder](#copy-old-logs-to-archive-folder)

<!-- /MarkdownTOC -->


## arguments

- `/mt:<threads>` - Creates multi-threaded copies with `<threads>` threads. `<threads>` must be an integer between `1` and `128`. The default value for `<threads>` is `8`.
The `/mt` parameter cannot be used with the /IPG and /EFSRAW parameters.
Redirect output using /LOG option for better performance.
Note: The /MT parameter applies to Windows Server 2008 R2 and Windows 7.
- `/m` - Copies only files for which the Archive attribute is set, and resets the Archive attribute.
Windows set Archive attribute automatically after file changing.
- `/log+:<path_to_log_file>` - Writes the status output to the log file (appends the output to the existing log file).
- Retries
    - `/z` - Copies files in Restart mode. Retries copying if it was interrupted. Use with `/R:<Num>`.
    - `/r:<Num>` - Specifies the number of retries on failed copies. The default value of `<Num>` is `1000000` (one million retries).
    - `/w:<SEC>` - Specifies the wait time between retries, in seconds. The default value of `<SEC>` is `30` (wait time 30 seconds).


## examples

###  copy old logs to archive folder

```
robocopy d:\source\path\to\logs d:\target\path\to\archive *.* /MOV /S /NFL /MinLAD:5
```

- `/MOV` - to move instead copy.
- `/MinLAD:5` - move all files *except* used since 5 days
(or `/MinLAD:20010201` to exlude files after 2001-02-01)
- `/S` - move from subdirs
- `/NFL` - no log each files to console

Example of Batch-script to archive old logs

```
@echo off

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM ----- Settings -----
set logs_dir=d:\path\to\logs
set archive_dir=d:\path\to\target\archive
set tmp_dir=d:\path\to\temp\dir
REM --------------------

if not exist "%tmp_dir%" mkdir "%tmp_dir%"
DEL /F /S /Q "%tmp_dir%\*"

REM Current date and time into variables
REM `year`, `month`, `day`, `hour`, `min` and `secs`
set year=%date:~-4%
set month=%date:~3,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~0,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%
set datetimef=%year%%month%%day%_%hour%%min%%secs%
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set datetime_filesuffix=%year%%month%%day%_%hour%%min%%secs%

robocopy "%logs_dir%" "%tmp_dir%" *.* /MOV /S /NFL /MinLAD:5

7z a -sdel "%archive_dir%\logs_%datetime_filesuffix%.7z" %tmp_dir%\*

pause
```

