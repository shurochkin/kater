### browserify task
   ---------------
   Bundle javascripty things with browserify!

   This task is set up to generate multiple separate bundles, from
   different sources, and to use Watchify when run from the default task.

   See browserify.bundleConfigs in gulp/config.js
###

browserify = require('browserify')
browserSync = require('browser-sync')
watchify = require('watchify')
mergeStream = require('merge-stream')
bundleLogger = require('../util/bundleLogger')
gulp = require('gulp')
handleErrors = require('../util/handleErrors')
source = require('vinyl-source-stream')
config = require('../config').browserify
_ = require('lodash')

browserifyTask = (devMode) ->

  browserifyThis = (bundleConfig) ->
    if devMode
      # Add watchify args and debug (sourcemaps) option
      _.extend bundleConfig, watchify.args, debug: true
      # A watchify require/external bug that prevents proper recompiling,
      # so (for now) we'll ignore these options during development. Running
      # `gulp browserify` directly will properly require and externalize.
      bundleConfig = _.omit(bundleConfig, [
        'external'
        'require'
      ])
    b = browserify(bundleConfig)

    bundle = ->
      # Log when bundling starts
      bundleLogger.start bundleConfig.outputName
      b.bundle()
        .on('error', handleErrors)
        .pipe(source(bundleConfig.outputName))
        .pipe(gulp.dest(bundleConfig.dest))
        .pipe browserSync.reload(stream: true)

    if devMode
      # Wrap with watchify and rebundle on changes
      b = watchify(b)
      # Rebundle on update
      b.on 'update', bundle
      bundleLogger.watch bundleConfig.outputName
    else
      # Sort out shared dependencies.
      # b.require exposes modules externally
      if bundleConfig.require
        b.require bundleConfig.require
      # b.external excludes modules from the bundle, and expects
      # they'll be available externally
      if bundleConfig.external
        b.external bundleConfig.external
    bundle()

  # Start bundling with Browserify for each bundleConfig specified
  mergeStream.apply gulp, _.map(config.bundleConfigs, browserifyThis)

gulp.task 'browserify', ->
  browserifyTask()
# Exporting the task so we can call it directly in our watch task, with the 'devMode' option
module.exports = browserifyTask
