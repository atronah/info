# Sublime Text

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [Settings](#settings)
    - [usefull](#usefull)
- [Used packages](#used-packages)
- [Notes about packages](#notes-about-packages)
    - [Compare Side-By-Side](#compare-side-by-side)
    - [MarkdownTOC](#markdowntoc)
    - [PackageResourceViewer](#packageresourceviewer)
    - [SQLTools](#sqltools)
    - [Not used packages](#not-used-packages)

<!-- /MarkdownTOC -->


## Settings

- [Preferences](https://github.com/atronah/configs/blob/master/sublime_text/Preferences.sublime-settings)
- Key bindings:
    - [Windows](https://github.com/atronah/configs/blob/master/sublime_text/Default%20(Windows).sublime-keymap)
    - [OSX](https://github.com/atronah/configs/blob/master/sublime_text/Default%20(OSX).sublime-keymap)


### usefull

- [Rainbow colors by JSON object level with any color scheme](https://forum.sublimetext.com/rainbow-colors-by-json-object-level-with-any-color-scheme/42968)



## Used packages

- `AutoBackups`
- [Compare Side-By-Side](#compare-side-by-side)
- `Exalt`
- `Git` - to manage git repos.
- `HTML5`
- `Indent XML`
- `IndentX`
- `JSONLint`
- `JSONTree`
- `Markdown Table Formatter`
- `MarkdownEditing` - Main plugin with markdown tools.
- `MarkdownPreview`
- [MarkdownTOC](#markdowntoc)
- `Pretty JSON`
- `Print to HTML`
- `Requester`
- `SideBarEnhancements` - For adding file operations like `Rename file`.
- `sql-fomratter`
- [SQLTools](#sqltools)
- `SublimeLinter-xmllint`
- `TrailingSpaces` - For removing extra spaces.
- `xml2json`
- `xpath`


## Notes about packages


### Compare Side-By-Side

Has problem in Sublime Text 4: opens both tabs on one side.


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


### PackageResourceViewer
...
### SQLTools

[Project page on GitHub](https://github.com/mtxr/SublimeText-SQLTools)

To fix encoding issue for Firebird connections,
add `-ch {encoding}` into `cli_options.firebird.args` in `SQLTools.sublime-settings`.



### Not used packages

- `A File Icon`
- `Git Blame`
- `JSON Reindent`
- `Markdown Code Blocks` - To hightlight block of codes.