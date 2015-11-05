gulp = require('gulp')
config = require('../config').production
minifyCSS = require('gulp-minify-css')
size = require('gulp-filesize')
gulp.task 'minifyCss', [ 'compass' ], ->
  gulp.src(config.cssSrc).pipe(minifyCSS(keepBreaks: true)).pipe(gulp.dest(config.dest)).pipe size()
