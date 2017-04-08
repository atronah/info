### show all commits of specified user

```
svn log | sed -n '/username/,/-----$/ p'
```