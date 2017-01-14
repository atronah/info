commit message
--------------
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
