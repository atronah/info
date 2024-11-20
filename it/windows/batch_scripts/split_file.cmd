@echo off
REM https://stackoverflow.com/questions/23593556/batch-split-a-text-file

setlocal enableextensions disabledelayedexpansion

set "line=0"

for /f %%a in ('type %1 ^|find /c /v ""') do set "fileLines=%%a"

< "%1" (for /l %%a in (1 1 %fileLines%) do (
    set /p "data="
    set /a "file_num=line/%2", "line+=1"
    setlocal enabledelayedexpansion
    set filename="%~dpn1_part_!file_num!%~x1"
    >>"!filename!" echo(!data!
    endlocal
))

endlocal