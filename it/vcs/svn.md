<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [ports](#ports)
- [show all commits of specified user](#show-all-commits-of-specified-user)

<!-- /MarkdownTOC -->

### ports

info from [stackoverflow.com](https://stackoverflow.com/questions/7249097/what-ports-need-to-be-open-for-tortoisesvn-to-authenticate-clear-text-and-comm):

- If your URL looks like: http://subversion/repos/, then you're probably going over Port `80`.
- If your URL looks like: https://subversion/repos/, then you're probably going over Port `443`.
- If your URL looks like: svn://subversion/, then you're probably going over Port `3690`.
- If your URL looks like: svn+ssh://subversion/repos/, then you're probably going over Port `22`.
- If your URL contains a port number like: http://subversion/repos:8080, then you're using that port.


### show all commits of specified user

```
svn log | sed -n '/username/,/-----$/ p'
```