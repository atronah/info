# Working with DBF


## dbf

simple example:

```py
t = dbf.Table('my_data.dbf', codepage='cp866', unicode_errors='ignore')
for f in t.field_names:
    print(f)

n = t.new('new_data.dbf', field_specs=t.structure())

t.open(dbf.READ_ONLY)
n.open(dbf.READ_WRITE)
for r in t:
    n.append(r)
t.close()
n.close()
```


### Table

```py
__init__(filename, field_specs=None, memo_size=128, ignore_memos=False,
         codepage=None, default_data_types=None, field_data_types=None,    # e.g. 'name':str, 'age':float
         dbf_type=None, on_disk=True, unicode_errors='strict')
```

- properies
    - `field_names`
- methods:
    - `structure()` - returns list with text declaration of each fields like `F_NAME C(10)`
    - `rename_field(old_name, new_name)`
    - `new(filename, field_specs=None, memo_size=None, ignore_memos=None, codepage=None, default_data_types=None, field_data_types=None, on_disk=True)` - returns a new table of the same type
    - `append(record)`



## dbfread


```py
from dbfread import DBF
table = DBF('people.dbf')
for record in table:
    print(record)
```
