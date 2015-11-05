gulp = require('gulp')
config = require('../config').markup
browserSync = require('browser-sync')
gulp.task 'markup', ->
  gulp.src(config.src)
  	.pipe(gulp.dest(config.dest))
  	.pipe browserSync.reload(stream: true)
