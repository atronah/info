Удаление всех триггеров
```
mysql --skip-column-names b15 -e 'SHOW TRIGGERS;' | cut -f1 | sed -r 's/(.*)/DROP TRIGGER IF EXISTS \1;/' | mysql database_name
```