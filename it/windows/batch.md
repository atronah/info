**tags**: windows, bat, shell

SETLOCAL
--------
### Localization enviroment changes
`SETLOCAL` at the beggining of the batch file to prevent changes in global enviroment. See `SETLOCAL /?` to details.

additional arguments:
- `ENABLEEXTENSIONS` \ `DISABLEEXTENSIONS` - enable\disable command processor extensions.
- `ENABLEDELAYEDEXPANSION`  \ `DISABLEDELAYEDEXPANSION` - enable\disable delayed enviroment variable expansion.

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



