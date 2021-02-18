# MySql

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Tips](#tips)
    - [remove all triggers](#remove-all-triggers)

<!-- /MarkdownTOC -->

## Tips

### remove all triggers
```
mysql --skip-column-names b15 -e 'SHOW TRIGGERS;' | cut -f1 | sed -r 's/(.*)/DROP TRIGGER IF EXISTS \1;/' | mysql database_name
```