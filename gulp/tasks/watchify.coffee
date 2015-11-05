gulp = require('gulp')
browserifyTask = require('./browserify')
gulp.task 'watchify', ->
  # Start browserify task with devMode === true
  browserifyTask true
