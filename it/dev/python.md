# Python

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [built-in](#built-in)
    - [open\(\)](#open)
- [Microservices](#microservices)
    - [Frameworks](#frameworks)
    - [Articles](#articles)
- [Environment](#environment)
- [Tips & tricks](#tips--tricks)
    - [vivisying dictionary](#vivisying-dictionary)

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


## Environment

- `python -m venv flask` - creates virtual environment (need Python 3.4 or above)


## Tips & tricks


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