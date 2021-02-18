# JavaScript

<!-- MarkdownTOC autolink="true" lowercase="all" uri_encoding="false" -->

- [React](#react)
    - [Using class-method as a handler, passed to child component by attributes](#using-class-method-as-a-handler-passed-to-child-component-by-attributes)

<!-- /MarkdownTOC -->


## React


### Using class-method as a handler, passed to child component by attributes

first way:

```js
class App
    constructor() {
        // do something
        // handler should be binded to this object
        this.handler = this.handler.bind(this)
    }

    // handler as a class method
    handler(param){
        // do something
    }

    render() {
        return <MyComponent onClick={this.handler}>
    }
```

second way:

```js
class App
    constructor() {
        // do something
    }

    // handler as a link to unnamed lambda-function
    handler = param => {
        // do something
    }

    render() {
        return <MyComponent onClick={this.handler}>
    }
```
