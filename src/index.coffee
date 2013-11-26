Compiler = require('es6-module-transpiler').Compiler

compilerMethods =
  commonjs: 'toCJS'
  amd: 'toAMD'
  globals: 'toGlobals'

module.exports = class ES6ModuleTranspiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'js'

  constructor: (config) ->
    @debug = config?.es6ModuleTranspiler?.debug? or no
    @match = new RegExp(config?.es6ModuleTranspiler?.match or /^app/)
    @moduleType = config?.es6ModuleTranspiler?.type or 'commonjs'

    console.log '---> es6-matching:', @match if @debug

  compile: (params, callback) ->
    if @match.test(params.path)
      console.log('---> es6-compiling:', params.path) if @debug
      compiler = new Compiler params.data, params.string
      return callback null, {data: compiler[compilerMethods[@moduleType] or 'toCJS']()}

    else
      console.log('---> es6-ignoring:', params.path) if @debug
      return callback(null, {data: params.data})

