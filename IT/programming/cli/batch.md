**tags**: windows, bat, shell

SETLOCAL
--------
### Localization enviroment changes
`SETLOCAL` to start localizations changes
`ENDLOCAL` to end (executed for all setlocal of this batch file automaticaly when end of batch file is reached).
additional arguments:
- `ENABLEEXTENSIONS` \ `DISABLEEXTENSIONS` - enable\disable command processor extensions.
- `ENABLEDELAYEDEXPANSION`  \ `DISABLEDELAYEDEXPANSION` - enable\disable delayed enviroment variable expansion.

ECHO
----
- `echo %var%` - displays value of `VAR` if it exists, otherwise echo on\off mode state.
- `echo:%var%` - displays value of `VAR` if it exists, otherwise empty line.
- `echo.` or `echo[` or `echo(` or `echo:` - displays empty (blank) line


CALL
----
- `call xxx.bat` - execute other batch-file without interrupting current. Resolve trouble with displaing parentheses of code blocks, when `echo off`.


