# Bash


## Best practices

### Shebang

Quote from [stackoverflow](http://stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang):
> You should use `#!/usr/bin/env bash` for portability:
> different unix put bash in different places,
> and using `/usr/bin/env` is a workaround to run the first bash found on the PATH.
> And sh is not bash.


### Variables

- get part of file name ([source](https://stackoverflow.com/questions/18845814/bash-extracting-file-basename-from-long-path)):
    - `filename="${fullpath##*/}"`
    - `filename_without_extension="${fullpath%.*}"`