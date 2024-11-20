@echo off

REM https://stackoverflow.com/a/23596719/10258952

set filename_prefix=%~dpn1
set filename_ext=%~x1
set lines_limit=%2

setlocal EnableDelayedExpansion

findstr /N "^" %1 > temp.txt
set linenum=0
call :splitFile < temp.txt
del temp.txt
goto :EOF

:splitFile
set /A linenum+=1
(for /L %%i in (1,1,%lines_limit%) do (
   set "line="
   set /P line=
   if defined line echo(!line:*:=!
)) >  %filename_prefix%_part_%linenum%%filename_ext%.txt
if defined line goto splitFile
exit /B