gulp = require("gulp")
browserSync = require("browser-sync")
handleErrors = require("../util/handleErrors")
jade = require('gulp-jade')
rename = require('gulp-rename')
config = require("../config").jade


gulp.task 'jade', ->
  gulp.src(config.src)
  	.pipe(jade()).on("error", handleErrors)
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload(stream: true))

  gulp.src(config.indexSrc)
  	.pipe(jade()).on("error", handleErrors)
    .pipe(rename('index.html'))
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload(stream: true))


