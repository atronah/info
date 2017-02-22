.gitconfig
----------
recomended config:
```ini
; default user info
[user]
    name = user
    email = user_post@example.com

[help]
    ; "info" - corresponds to -i|--info,
    ; "web" or "html" correspond to -w|--web.
    ; "man" corresponds to -m|--man,
    format = html

[core]
    autocrlf = true
    ; to prevent troubles with cyrillic in console (see https://habrahabr.ru/post/74839/)
    quotepath = false

[i18n]
    ; NOTE: to make Vim display cyrillic correctly you have to set LANG=ru_RU.UTF-8
    ; no longer needed, becouse default settings work correct
    #commitencoding = utf-8
    #logoutputencoding = utf-8

[pull]
    ; to prevent merge
    ff = true
    ; try to rebase your local changes on top of remote branch during pull. 
    ; instead I prefer to use alias "pullr" (see bellow)
    #rebase = true

[push]
    default = simple
    ; to prevent fast-forwarding during push
    #ff = false

[merge]
    ; to prevent fast-forwarding during merge
    ff = false

[credential]
    ; to store your credentials into .git-credentials file
    helper = store

[alias]
    ci = commit
    fx = commit --fixup
    br = branch
    st = status
    co = checkout
    un = reset HEAD --
    ol = log --oneline
    mr = merge --no-ff
    last = log -1 HEAD
    unstage = reset HEAD --
    rollback = checkout --
    graph = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
    sm = submodule
    type = cat-file -t
    dump = cat-file -p
    pulr = pull --rebase
	wdiff = diff --word-diff=color

[gui]
    encoding = utf-8
```
