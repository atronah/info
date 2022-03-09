# git

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [.gitconfig](#gitconfig)
- [status](#status)
- [gitrevisions](#gitrevisions)
- [rebase](#rebase)
- [double and triple dots](#double-and-triple-dots)
- [best practices](#best-practices)
	- [commit message](#commit-message)
- [check leaks](#check-leaks)
- [GitLab](#gitlab)
	- [curl API examples](#curl-api-examples)
- [GitHub](#github)
	- [curl API examples](#curl-api-examples-1)
- [links](#links)

<!-- /MarkdownTOC -->



## .gitconfig

[my version of config on GitHub](https://github.com/atronah/configs/blob/master/.gitconfig)


## status

[git-branch-status script](https://github.com/bill-auger/git-branch-status)


## gitrevisions

`@{u}` (“u” stands for “upstream”) it resolves to the latest commit on this branch on the remote ([merge-vs-rebase](http://mislav.net/2013/02/merge-vs-rebase/))
- parents of commit (usual commit has only one parent, but merge can has more)
    - `<ref>^0` - commit itself
    - `<rev>^` (equivalent `<rev>^1`) - first parent of commit
    - `<rev>^<n>` - `<n>`th parent of commit
- `<rev>~<n>` - `<n>`-th ancestor of commit (note that `<rev>~3` is equivalent to `<rev>^^^` (great-grandparent of of commit) or `<rev>^1^1^1`
- specifying type of commit
    - `<ref>^{tag}` - can be used to ensure that rev identifies an existing tag object.
- `<ref>^{:/regexp}`- the youngest commit which is reachable from the `<rev>` and which is reachable from any ref
- `<ref>^{/regexp}` - the youngest commit which is reachable from the `<rev>` and which is reachable from the `<rev>`


## rebase
see more in [git rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)

`git rebase --onto master server client` - Take the client branch, figure out the patches since it diverged from the server branch,
and replay these patches in the client branch as if it was based directly off the master branch instead:
![rebasing client onto master](git_images/git_rebase_client_server.png)


## double and triple dots

Some images got from [StackOverflow topic](http://stackoverflow.com/questions/462974/what-are-the-differences-between-double-dot-and-triple-dot-in-git-com)

| ![](git_images/git_log_doubledot_euler.png) | ![](git_images/git_log_tripledot_euler.png)     |
|---------------------------------------------|-------------------------------------------------|
| ![](git_images/git_log_doubledot.png)       | ![](git_images/git_log_tripledot_branches.png)  |
| ![](git_images/git_log_rev_list.png)        | ![](git_images/git-diff-help.png)               |


-----------------


## best practices

### commit message

_some of rules was borrowed from [AngularJS](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md) project_

Commit message have to match the pattern:
```
<type>(<scope>): <subject> [#<ticket number>]
<blank line>
<detailed description>
<blank line>
<other metadata>
```
where:
- `<type>` - one of the following keywords to simplify the automatic generation of changelog:
	- **fx** - A bug fix
	- **ft** - A new feature
	- **rf** - A refactoring (changes without changing behaviour)
		- **cln** - removing files, extra spaces, blank lines, unused variables
		- **opt** - optimisation
		- **stl** - A code reformatting (removes blank lines, extra spaces, case changing, etc)
	- **docs** - a documentation of code
	- **sm** - A submodule changing
	- **misc** - miscellaneous changes
- `<scope>` - name of changes scope (or modified file name in simple case)
	- **refs** - references (e.g., external documents)
	- **meta** - meta data about project (version, licenses, todoes)
- `<short description>` is a short changes description of commit in Present tense, which answers the question "what does this commit do?".
- `<ticket number>` - (optional) related issue number
- `<detailed description>' - more detailed multi-line description of made changes
- `<other metadata>` - tags for search, meta data for various parsers


## check leaks

[source](https://habr.com/ru/post/459552/)

```
pip install gittyleaks
gittyleaks --find-anything

git log --diff-filter=D --summary
```

-----------------


## GitLab

- script to backup repositories from GitLab using API: [gitlab_backup.sh](gitlab_backup.sh)


### curl API examples

set up [access token](https://gitlab.com/-/profile/personal_access_tokens)

```shell
gl_token=...
```

get 20 projects available for user with `${gl_token}`

```bash
curl --header "Authorization: Bearer ${gl_token}" https://gitlab.com/api/v4/projects
```

get 100 projects url where user with `${gl_token}` (passed as url argument) is a member

```bash
curl https://gitlab.com/api/v4/projects -d access_token=${gl_token} -d membership=true -d per_page=100 | grep -oP '"http_url_to_repo":\s*"\K[^"]*'
```

get 20 notes for issue `47` in project mplus/eis

```bash
curl -G --header "Authorization: Bearer ${gl_token}" https://gitlab.com/api/v4/projects/1136146/issues/47/notes
```


## GitHub

- script to backup repositories from GitLab using API: [githab_backup.sh](githab_backup.sh)


### curl API examples

set up [access token](https://github.com/settings/tokens)

```
ghtoken=...
```


get info about specified user (in example - about user `atronah`)

```bash
curl -u "atronah:${ghtoken}" https://api.github.com/users/atronah
```



get info about current user (owner of token)

```bash
curl -u "atronah:${ghtoken}" https://api.github.com/user
```


get all repos of user (in example - about user `atronah`)

```bash
curl -u "atronah:${ghtoken}" https://api.github.com/users/atronah/repos
```



## links

- https://githowto.com/ru
- http://www-cs-students.stanford.edu/~blynn/gitmagic/intl/ru/ch05.html
- https://githowto.com/ru/history
- https://habrahabr.ru/post/161009/
- http://mislav.net/2013/02/merge-vs-rebase/
- https://git-scm.com/book/ru/v1/Ветвление-в-Git-Перемещение
- http://stackoverflow.com/questions/269352/patch-vs-hotfix-vs-maintenance-release-vs-service-pack-vs
- https://github.com/imangazaliev/git-tips
