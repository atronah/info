# How To Fix

## Failed building wheel, Python.h not found


Full error text:

```
Using cached backports.zoneinfo-0.2.1.tar.gz (74 kB)
...
Building wheel for backports.zoneinfo (pyproject.toml) did not run successfully.
...
lib/zoneinfo_module.c:1:10: fatal error: 'Python.h' file not found
error: command '/usr/bin/clang' failed with exit code 1
ERROR: Failed building wheel for backports.zoneinfo
```

Occurrence conditions: Installing [mutex_bot](https://github.com/atronah/mutex_bot/commit/8a84a884abab97a16389ef45b1a18c5b583d87a8) in python 3.8.9 venv


Solution:

- (not sure) `brew install python-build`
- find Python.h by `sudo find / -name Python.h`
- run `pip install` with specifying env variable `C_INCLUDE_PATH`:
    ```
    C_INCLUDE_PATH="/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.8/Headers/" pip install .
    ```

Source: https://stackoverflow.com/questions/24391964/how-can-i-get-python-h-into-my-python-virtualenv-on-mac-osx
