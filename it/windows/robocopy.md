# ROBOCOPY


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


### copy old logs to archive folder

```
robocopy d:\source\path\to\logs d:\target\path\to\archive *.* /MOV /S /NFL /MinLAD:5
```

- `/MOV` - to move instead copy.
- `/MinLAD:5` - move all files *except* used since 5 days
- `/S` - move from subdirs
- `/NFL` - no log each files to console