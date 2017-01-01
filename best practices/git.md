commit message
--------------
_some of rules was borrowed from [AngularJS](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md) project_

Commit message have to match the pattern:
```
<changes type>(<changes scope>): <short description> [#<ticket number>]

<detailed description>

<other metadata>
```
where:
- `<changes type>` - one of the following keywords to simplify the automatic generation of changelog:
	- **docs** - change documentation
	- **fx** - fixing bugs
	- **rf** - refactoring (change logic of the solutions without change API and results)
	- **arrange** - arrange file structure of project
	- **ft** - add new features
	- **rm** - remove existing functionality 
	- **style** - change appearance of sources and docs files
	- **mt** - change meta data about project (version, licenses)
	- **sm** - change in submodules
	- **refs** - change references (e.g., external documents)
- `<changes scope>` - name of changes scope or modified file name in simple case
- `<short description>` is a short changes description of commit in Present tense, which answers the question "what does this commit do?".
- `<ticket number>` - (optional) related issue number
- `<detailed description>' - more detailed multi-line description of made changes
- `<other metadata>` - tags for search, meta data for various parsers
