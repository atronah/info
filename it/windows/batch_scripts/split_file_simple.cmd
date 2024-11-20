@echo off
REM simplified (by atronah) version from https://stackoverflow.com/a/23594307/10258952


setlocal enabledelayedexpansion

set "line=0"

for /f "usebackq delims=" %%a in ("%1") do (
    set /a "file_num=line/%2", "line+=1"
	set filename=%~dpn1_part_!file_num!%~x1
    echo %%a >>!filename!	
)

endlocal