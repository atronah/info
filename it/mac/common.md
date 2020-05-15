### Move/drag window by clicling within t

([source](https://superuser.com/a/1466919),
[source2](http://www.mackungfu.org/UsabilityhackClickdraganywhereinmacOSwindowstomovethem))


Run this command in terminal to enable Ctrl + Cmd + Click in any window to move. Restart after.
```
# to add
defaults write -g NSWindowShouldDragOnGesture -bool true
```

Run this command in terminal to remove this functionality. Restart after.
```
# to remove
defaults delete -g NSWindowShouldDragOnGesture
```