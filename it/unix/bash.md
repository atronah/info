# Bash

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Best practices](#best-practices)
    - [Shebang](#shebang)
    - [Variables](#variables)
    - [Debugging](#debugging)
- [Tips & tricks](#tips--tricks)
    - [inline for](#inline-for)
    - [do not put command in history](#do-not-put-command-in-history)
    - [parts of file path](#parts-of-file-path)
    - [remove part of string](#remove-part-of-string)
    - [capture stdout to a variable but still display it in the console](#capture-stdout-to-a-variable-but-still-display-it-in-the-console)
    - [process arguments/options by getopts](#process-argumentsoptions-by-getopts)

<!-- /MarkdownTOC -->


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


### Debugging

([source](https://habr.com/ru/post/666982/))

to display each command and wait user input before run it, add this line after line with [shebang (`!#`)](#shebang):

```bash
trap 'echo "# $BASH_COMMAND";read' DEBUG
```


## Tips & tricks

### inline for

- ```for i in *.tif; do mv -i $i `basename $i .tif`; done```
- ```for f in $(ls -1t *.7z | tail -n +7); do rm "$f"; done```


### do not put command in history

If option `HISTCONTROL=ignorespace` exists in `.bashrc`
you should put space before command to prevent putting it in history log.


### parts of file path

```bash
absolute_path="$( cd "$(dirname "$relative_path")" >/dev/null 2>&1 ; pwd -P )"

dirname=$(dirname -- $fullpath)
filename=$(basename -- "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"

# Alternatively, you can focus on the last '/' of the path instead of the '.'
# which should work even if you have unpredictable file extensions:
filename="${fullfile##*/}"
```

- [stackoverflow](https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash),
- ["3.5.3 Shell Parameter Expansion" on gnu.org](http://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)


### remove part of string

```bash
var="abcde1234abcde"
echo "${var#a*c} = de1234abcde" # remove all between `a` and `c`, starting from left side, shortest match
echo "${var##a*c} = de" # remove all between `a` and `c`, starting from left side, longest match
echo "${var%c*e} = abcde1234ab" # remove all between `c` and `e`, starting from right side, shortest match
echo "${var%%c*e} = ab" # remove all between `c` and `e`, starting from right side, longest match
```

- `#` (lazy, shortest match) and `##` (greedy, longest match) work from the left end (beginning) of string;
pattern should start from first symbol of string (`x*` for string `x...`)
- `%` (lazy, shortest match) and `%%` (greedy, longest match) work from the right end;
pattern should end with last symbol of string (`*y` for string `...y`)

example: `var=93%; echo "${var%\%}"` shows `93`

source: [Advanced Bash-Scripting Guide: 10.2. Parameter Substitution](https://tldp.org/LDP/abs/html/parameter-substitution.html#PSOREX1)


### capture stdout to a variable but still display it in the console
([source](https://stackoverflow.com/a/12451419))

```
# redirect 5th file descriptor to stdout
exec 5>&1

# run command `echo` and out its result to variable `command_result` and to 5th file descriptor (i.e. to stdout)
command_result=$(echo aaa|tee >(cat - >&5))

#out content of `command_result` (in quotes to preserve newline symbols)
echo "$command_result"
```


### process arguments/options by getopts

```bash
usage () {
    echo "usage: test.sh [arguments]"
    echo ""
    echo "arguments:"
    echo "-v                (optional) verbose"
    echo "-h                (optional) show this help"
    echo "-f FILENAME       (required) specify filename to process (default 'default.file')"
}

verbose=false
filename="default.file"

# Parse arguments
# f - required
while getopts "v,h,f:" opt; do
    case $opt in
        v) verbose=true
        ;;
        h) usage && exit 0
        ;;
        f) filename="$OPTARG"
        ;;
        *) echo "Invalid option or its argument: -$OPTARG" >&2
        usage && exit 1
        ;;
    esac
done

# remain other unprocessed arguments in "$@"
shift "$OPTIND"

if [ $verbose = true ]; then
    echo "verbose info"
fi
```
