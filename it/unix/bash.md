Best practices 
==============

### Shebang

Quote from [stackoverflow](http://stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang):
> You should use `#!/usr/bin/env bash` for portability:
> different *nixes put bash in different places,
> and using `/usr/bin/env` is a workaround to run the first bash found on the PATH.
> And sh is not bash.
