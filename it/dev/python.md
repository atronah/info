# Python

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [built-in](#built-in)
    - [open\(\)](#open)
- [Microservices](#microservices)
    - [Frameworks](#frameworks)
    - [Articles](#articles)
- [Virtual environment](#virtual-environment)
- [Tips & tricks](#tips--tricks)
    - [fast way to show used pathes](#fast-way-to-show-used-pathes)
    - [installed packages](#installed-packages)
    - [vivisying dictionary](#vivisying-dictionary)
    - [non-default source folder](#non-default-source-folder)

<!-- /MarkdownTOC -->


## built-in

### open()

- `r` - Open text file for reading. The stream is positioned at the beginning of the file.
- `r+` - Open for reading and writing. The stream is positioned at the beginning of the file.
- `w` - Truncate file to zero length or create text file for writing.
The stream is positioned at the beginning of the file.
- `w+` - Open for reading and writing.
The file is created if it does not exist, otherwise it is truncated.
The stream is positioned at the beginning of the file.
- `a` - Open for writing. The file is created if it does not exist.
The stream is positioned at the end of the file.
Subsequent writes to the file will always end up at the then current end of file,
irrespective of any intervening fseek(3) or similar.
- `a+` - Open for reading and writing.
The file is created if it does not exist.
The stream is positioned at the end of the file.
Subse-quent writes to the file will always end up at the then current end of file,
irrespective of any intervening fseek(3) or similar.



## Microservices

### Frameworks
- Flask ([example](http://eax.me/python-flask/))
- Falcon
- Tornado


### Articles
- [Microservices with Python, RabbitMQ and Nameko](http://brunorocha.org/python/microservices-with-python-rabbitmq-and-nameko.html)


## Virtual environment

- by `venv` module of Python
    - `python -v venv ./my_venv` - creates virtual environment (needs Python 3.4 or above)
    - `source ./my_venv/bin/activate` - activate virtual environment for current shell
    - `deactivate`
- by [pyenv](/it/app/pyenc.md) and [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
    - `pyenv versions` - shows available (installed) versions
    - `pyenv version` - shows current version
    - `pyenv install 3.9.6` - install new version
    - `pyenv local 3.9.6` - use 3.9.6 for current directory. 
    Priority ([source](https://realpython.com/intro-to-pyenv/)): 
        - `pyenv shell` (`$PYENV_VERSION` env var)
        - `pyenv local` (`.python-version` file)
        - `pyenv global` (`~/.pyenv/version`)
        - System python by system
    - `pyenv virtualenv 3.9.6 my-virtual-env-3.9.6` - creates new copy of installed version as a virtual environment


## Tips & tricks


### fast way to show used pathes

- `python -m site`


### installed packages

- `pip list`


### vivisying dictionary

([source](http://robb.re/notes/2015-02-09-pyramid-traversal.html))

```python
import collections

def vivify():
    return collections.defaultdict(vivify)

d = vivify()
d['a']['b']['c'] = 'd'

print(d['a']['b']['c'])
```


### non-default source folder

(source)[https://stackoverflow.com/questions/64838393/package-dir-in-setup-py-not-working-as-expected]

If you have project structure like this

```
project
    setup.py
    my_src
        my_package
            __init__
```

your setup.py have to contain

```
setuptools.setup(
package_dir={'': 'my_src'},
packages=['my_package'])
```

and it works fine as for both regular `pip install` and editable install `pip install --editable`.


But configuration 

```
setuptools.setup(
package_dir={'my_package': 'my_src/my_package'},
packages=['my_package'])
```

for the same structure 

or configuration 

```
setuptools.setup(
package_dir={'my_package': 'other_name'},
packages=['my_package'])
```

for structure

```
project
    setup.py
    other_name
        __init__
```

doesn't work for editable install `pip install --editable`, just for normal install `pip install`.

