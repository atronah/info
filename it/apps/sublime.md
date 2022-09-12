# Sublime Text

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Settings](#settings)
- [Plugins](#plugins)
    - [A File Icon](#a-file-icon)
    - [Compare Side-By-Side](#compare-side-by-side)
    - [Git](#git)
    - [Git Blame](#git-blame)
    - [Indent XML](#indent-xml)
    - [JSON Reindent](#json-reindent)
    - [Markdown Code Blocks](#markdown-code-blocks)
    - [Markdown Editing](#markdown-editing)
    - [MarkdownTOC](#markdowntoc)
    - [SideBarEnhancements](#sidebarenhancements)
    - [TrailingSpaces](#trailingspaces)
    - [SQLTools](#sqltools)

<!-- /MarkdownTOC -->


## Settings

- [Preferences](https://github.com/atronah/configs/blob/master/sublime_text/Preferences.sublime-settings)
- Key bindings:
    - [Windows](https://github.com/atronah/configs/blob/master/sublime_text/Default%20(Windows).sublime-keymap)
    - [OSX](https://github.com/atronah/configs/blob/master/sublime_text/Default%20(OSX).sublime-keymap)


## Plugins


### A File Icon

...


### Compare Side-By-Side

Has problem in Sublime Text 4: opens both tabs on one side.


### Git

To manage git repos.



### Git Blame

...


### Indent XML


...


### JSON Reindent

...


### Markdown Code Blocks

To hightlight block of codes.


### Markdown Editing

Main plugin with markdown tools.




### MarkdownTOC

[Official documentation](https://packagecontrol.io/packages/MarkdownTOC)

Useful example for GitLab projects:

```
<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->
```

Settings recomendations:

- to fix problem with replacing ` - ` (space + dash + space) by `---` (tripple dash) instead of `-` (single dash)
modify replacement pattern in `MarkdownTOC.sublime-settings` from

```json
{
    "pattern": "\\s+",
    "replacement": "-"
}
```

to

```json
{
    "pattern": "\\s+-*\\s*",
    "replacement": "-"
}
```





### SideBarEnhancements

For adding file operations like `Rename file`.


### TrailingSpaces

For removing extra spaces.



### SQLTools


[Project page on GitHub](https://github.com/mtxr/SublimeText-SQLTools)

To fix encoding issue for Firebird connections,
add `-ch {encoding}` into `cli_options.firebird.args` in `SQLTools.sublime-settings`.



