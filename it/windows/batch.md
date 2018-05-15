**tags**: windows, bat, shell

Paths
-----

### dirname

[source](http://stackoverflow.com/questions/778135/how-do-i-get-the-equivalent-of-dirname-in-a-batch-file)
- `for %%F in (%filename%) do set dirname=%%~dpF`
- `%filename%\..\ ` - **need check**


SETLOCAL
--------

### Localization environment changes

`SETLOCAL` at the beggining of the batch file to prevent changes in global environment. See `SETLOCAL /?` to details.

additional arguments:
- `ENABLEEXTENSIONS` \ `DISABLEEXTENSIONS` - enable\disable command processor extensions.
- `ENABLEDELAYEDEXPANSION`  \ `DISABLEDELAYEDEXPANSION` - enable\disable delayed environment variable expansion.
Using `!var!` instead `%var%` when enabled, to get current value of variable in blocks `( ... )` instead of pre-evaluated value.
([info source](https://stackoverflow.com/questions/22278456/enable-and-disable-delayed-expansion-what-does-it-do/22278518))


ECHO
----

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



