# es6-module-transpiler-brunch


Adds ES6 module syntax to [Brunch](http://brunch.io) based on Square's [es6-module-transpiler](https://github.com/square/es6-module-transpiler).

**ES6 Module Transpiler** is an experimental compiler that allows you to write your JavaScript using a subset of the current ES6 module syntax, and compile it into AMD or CommonJS modules.

## Usage
Install the plugin via npm with `npm install --save es6-module-transpiler-brunch`.

Or, do manual install:

* Add `"es6-module-transpiler-brunch": "x.y.z"` to `package.json` of your brunch app.
* If you want to use git version of plugin, add
`"css-brunch": "git+ssh://git@github.com:gcollazo/es6-module-transpiler-brunch.git"`.

## Supported ES6 Module Syntax

Again, this syntax is in flux and is closely tracking the module work being
done by TC39.

### Named Exports

There are two types of exports. *Named exports* like the following:

```javascript
// foobar.js
var foo = "foo", bar = "bar";

export { foo, bar };
```

This module has two named exports, `foo` and `bar`.

You can also write this form as:

```javascript
// foobar.js
export var foo = "foo";
export var bar = "bar";
```

Either way, another module can then import your exports like so:"

```javascript
import { foo, bar } from "foobar";

console.log(foo);  // "foo"
```

### Default Exports

You can also export a *default* export. For example, an ES6ified jQuery might
look like this:

```javascript
// jquery.js
var jQuery = function() {};

jQuery.prototype = {
  // ...
};

export default = jQuery;
```

Then, an app that uses jQuery could import it with:

```javascript
import $ from "jquery";
```

The default export of the "jquery" module is now aliased to `$`.

A default export makes the most sense as a module's "main" export, like the
`jQuery` object in jQuery. You can use default and named exports in parallel.

### Other Syntax

#### `module`

Whereas the `import` keyword imports specific identifiers from a module,
the `module` keyword creates an object that contains all of a module's
exports:

```javascript
module foobar from "foobar";
console.log(foobar.foo);  // "foo"
```

In ES6, this created object is *read-only*, so don't treat it like a mutable
namespace!

#### `import "foo";`

A "bare import" that doesn't import any identifiers is useful for executing
side effects in a module. For example:

```javascript
// alerter.js
alert("alert! alert!");

// alertee.js
import "alerter";  // will pop up alert box
```

## How the plugin works
The plugin will take all files ending in `*.js` under the `app` directory and pass them through the `es6-module-transpiler` and compiled as CommonJS modules.

## Plugin Config
The plugin has three configuration options you can add to your project's `config.coffee`:

`match` which is a regex used to decide what files to compile.
`type` which is the type of module the transpiler should compile.
`debug` which will `console.log` debugging info when the plugin runs.

```javascript
exports.config =
  es6ModuleTranspiler:
    match: /^app/
    type: 'commonjs' // other options: 'amd', 'globals'
    debug: yes
```

If compiling to AMD modules, you will need to include a module loader such as [almond](https://github.com/jrburke/almond) or [RequireJS](http://requirejs.org).
