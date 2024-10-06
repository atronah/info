# Async IO

## to read

- [asyncio official documentation](https://docs.python.org/3/library/asyncio.html)
- [Async IO in Python: A Complete Walkthrough](https://realpython.com/async-io-python/)
- Book `Asyncio и конкурентное программирование на Python` (Мэттью Фаулер, 2022)
- Probably deprecated, but funny
    - [Generator Tricks for Systems Programmers, v3.0](http://www.dabeaz.com/generators) (David Beazley, 2008)
    - [A Curious Course on Coroutines and Concurrency](http://www.dabeaz.com/coroutines/) (David Beazley, 2009)


## Generators and coroutines

- coroutines described in PEP-342


### yield

#### to make generator function (which produces iterable values)

- `yield some_value` - produces single returning value for generator output ([src](http://www.dabeaz.com/generators))
    ```py
    # call countdown returns generator object,
    # that produces sequence of numbers,
    # where is the next number less by one than previous one
    def countdown(n):
        while n > 0:
            yield n
            n -= 1

    # call countup returns generator object,
    # that produces sequence of numbers,
    # where is the next number more by one than previous one
    def countup(stop): n=1
        while n < stop:
            yield n
            n += 1
    ```
- `yield from generator_object` - delegates generating to another generator ([src](http://www.dabeaz.com/generators))
    ```py
    # call up_and_down returns generator object
    # which returns values at first from generator, made by countup
    # and after that returns values from generator, made by countdown
    def up_and_down(n):
        yield from countup(n)
        yield from countdown(n)
    ```
    , i.e. call `up_and_down(3)` returns generator that produces values `1, 2, 3, 2, 1`


#### to make coroutine function (which tend to consume values)

- `consumed_value = yield`



#### to mix generator and coroutines

- `consumed_value = (yield produced_value)`
(bogus idea, see slides 31-34 in [A Curious Course on Coroutines and Concurrency](http://www.dabeaz.com/coroutines/) by David Beazley, 2009)
    ```py
    def countdown(n):
        print "Counting down from", n
        while n >= 0:
            newvalue = (yield n)
            # If a new value got sent in, reset n with it
            if newvalue is not None:
                n = newvalue
            else:
                n -= 1
    ```

    ```py
    c = countdown(5)
    for n in c:
        print n
        if n == 5:
    c.send(3)
    # output values: `5`, `2`, `1`, `0`
    ```





### Example of pipelining data processing concept

([theory src](http://www.dabeaz.com/generators), [code src](https://github.com/dabeaz/generators/blob/master/examples/bytesgen.py))

Summarising bytes sens from enourmous log files from directories
(some log files could be compressed by gz or zip)

```py
pat    = r'ply-.*\.gz'
logdir = 'www'

filenames = gen_find("access-log*",logdir) # getting names of log files
logfiles  = gen_open(filenames) # openning files (with decompress if it is needed)
loglines  = gen_cat(logfiles) # concatenating lines from all log files into single stream
patlines  = gen_grep(pat,loglines) # filtering lines which contains pattern from `pat`
bytecol   = (line.rsplit(None,1)[1] for line in patlines) # getting value from last column of each log line
bytes_sent= (int(x) for x in bytecol if x != '-') # converting value to int type

print("Total", sum(bytes_sent)) # get sum of gotten values
```

Python analogue for `tail -f` unix command:

```py
def follow(thefile):
        thefile.seek(0, os.SEEK_END) # End-of-file
        while True:
             line = thefile.readline()
             if not line:
                 time.sleep(0.1)    # Sleep briefly
                 continue
             yield line
```
