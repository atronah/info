# Batch/CMD sripting

**tags**: windows, bat, shell


<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [inline for](#inline-for)
- [Dates and times](#dates-and-times)
- [Paths](#paths)
    - [dirname](#dirname)
- [SETLOCAL](#setlocal)
    - [Localization environment changes](#localization-environment-changes)
- [ECHO](#echo)
    - [troubles](#troubles)
- [Examples and snippets](#examples-and-snippets)
    - [Split file into parts with the specified numbers of lines](#split-file-into-parts-with-the-specified-numbers-of-lines)

<!-- /MarkdownTOC -->


## inline for

- ```for /f %f in ('dir /b c:\') do echo %f```

## Dates and times

```
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
```


## Paths

### dirname

[source](http://stackoverflow.com/questions/778135/how-do-i-get-the-equivalent-of-dirname-in-a-batch-file)
- `for %%F in (%filename%) do set dirname=%%~dpF`
- `%filename%\..\ ` - **need check**


## SETLOCAL

### Localization environment changes

`SETLOCAL` at the beggining of the batch file to prevent changes in global environment. See `SETLOCAL /?` to details.

additional arguments:
- `ENABLEEXTENSIONS` \ `DISABLEEXTENSIONS` - enable\disable command processor extensions.
- `ENABLEDELAYEDEXPANSION`  \ `DISABLEDELAYEDEXPANSION` - enable\disable delayed environment variable expansion.
Using `!var!` instead `%var%` when enabled, to get current value of variable in blocks `( ... )` instead of pre-evaluated value.
([info source](https://stackoverflow.com/questions/22278456/enable-and-disable-delayed-expansion-what-does-it-do/22278518))


## ECHO

- `echo %var%` - displays value of `VAR` if it exists, otherwise echo on\off mode state.
- `echo:%var%` - displays value of `VAR` if it exists, otherwise empty line.
- `echo.` or `echo[` or `echo(` or `echo:` - displays empty (blank) line


### troubles

- `echo %var%` displays state of __echo on\off__ mode, if `%var%` is undefined or it is `/?` or `on` or `off`.
Solution: use `echo[%var%` or `echo(%var%` or `echo:%var%`
- `echo.` failed, if current directory contains `echo` file.
Solution: use `echo[` or `echo(` or `echo:`
- used `echo off`, but parentheses of code blocks are displayed.
Solution: use `call xxx.bat` instead `xxx.bat` to execute nested batch files.


## Examples and snippets

### Split file into parts with the specified numbers of lines

- from [one disccussion on stackoverflow](https://stackoverflow.com/questions/23593556/batch-split-a-text-file)
    - [split_file.cmd](batch_scripts/split_file.cmd) - hard to understand and last version from a best answer of discussion
    (has problem with truncating line in position of `0x00` in it)
    - [split_file_simple.cmd](batch_scripts/split_file_simple.cmd) - simplified by me version 
    (has problem with truncating file part in position of line, that containing `0x00` character)
    - [split_file_simple.cmd](batch_scripts/split_file_simple.cmd) - fast version from another answer of the same discuession
    (has the same problem, as [split_file.cmd](batch_scripts/split_file.cmd): truncate each line with `0x00`)



