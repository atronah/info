# Python

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [workplace preparing](#workplace-preparing)
    - [install git](#install-git)
    - [install pyenv](#install-pyenv)
    - [install python](#install-python)
- [built-in](#built-in)
    - [open\(\)](#open)
- [usefull packages](#usefull-packages)
- [Microservices](#microservices)
    - [Frameworks](#frameworks)
    - [Articles](#articles)
- [Virtual environment](#virtual-environment)
- [Tips & tricks](#tips--tricks)
    - [fast way to show used pathes](#fast-way-to-show-used-pathes)
    - [installed packages](#installed-packages)
    - [vivisying dictionary](#vivisying-dictionary)
    - [non-default source folder](#non-default-source-folder)
    - [install sub-packages from git](#install-sub-packages-from git)

<!-- /MarkdownTOC -->

## workplace preparing

### install git


- CentOS 7
    - for old git 1.8.3.1
        ```bash
        yum install git
        ```
    - for latest git ([source](https://computingforgeeks.com/how-to-install-latest-version-of-git-git-2-x-on-centos-7/), in commands bellow specified version `2.36.1`)
        ```bash
        yum -y remove git*
        yum -y install epel-release
        yum -y groupinstall "Development Tools"
        yum -y install wget perl-CPAN gettext-devel perl-devel  openssl-devel  zlib-devel curl-devel expat-devel  getopt asciidoc xmlto docbook2X
        ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
        yum -y install wget
        export VER="2.36.1"
        wget https://github.com/git/git/archive/v${VER}.tar.gz
        tar -xvf v${VER}.tar.gz
        rm -f v${VER}.tar.gz
        cd git-*
        make configure
        ./configure --prefix=/usr
        make
        make install
        git --version
        ```
- Fedora 22 and later
    ```bash
    dnf install git
    ```


### install pyenv

for more details see [github repo of pyenv](https://github.com/pyenv/pyenv)

- Mac OS (Homebrew)
    ```bash
    brew update
    brew install pyenv
    ```
- Unix
    - by [installer](https://github.com/pyenv/pyenv-installer)
        ```bash
        curl https://pyenv.run | bash
        ```
    - by `git clone`
        ```bash
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        ```
- seting up
    - add into `~/.bash_profile` or `~/.profile` and into `~/.bashrc`
        ```bash
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        ```
- update
    ```bash
    pyenv update
    ```
- add auto-activation
    ```bash
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
    ```


### install python

- install requirements
    - install openssl 1.1 from repo
        ```
        yum install openssl11 openssl-devel
        ```
    - install openssl 1.1 from source ([source](https://gist.github.com/fernandoaleman/5459173e24d59b45ae2cfc618e20fe06))
        ```bash
        yum install gcc perl-core pcre-devel wget zlib-devel
        wget https://ftp.openssl.org/source/openssl-1.1.1k.tar.gz
        tar -xzvf openssl-1.1.1k.tar.gz
        cd openssl-1.1.1k
        ./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
        make
        make test
        make install
        ```
    - install other requirements
    ```bash
    yum install bzip2-devel openssl-devel readline-devel libffi-devel curl wget
    ```
- install by pyenv
    - simple
        ```bash
        pyenv install 3.10.4
        ```
    - for nonspecific openssl libraries and headers pathes
        ```bash
        CPPFLAGS="-I/usr/include/openssl11" \
        LDFLAGS="-L/usr/lib64/openssl11" \
        pyenv install 3.10.4
        ```
- set up as a primary python for your user account
    ```bash
    pyenv global 3.10.4
    ```


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



## usefull packages

- [to work with dbf files](dbf.md)


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


### install sub-packages from git

[source](https://python-packaging.readthedocs.io/en/latest/dependencies.html#packages-not-on-pypi)

```python
requires = [
    # ...
    'python-otrs @ git+https://github.com/ewsterrenburg/python-otrs.git@4d634a7c8ca08ab04583c29997c75bf2550bdc2a'
]

setup(
    # ...
    dependency_links=[
        'git+https://github.com/ewsterrenburg/python-otrs.git@master#egg=python-otrs-0'
    ],
    install_requires=requires,
)
```
