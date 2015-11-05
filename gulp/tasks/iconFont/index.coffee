gulp = require('gulp')
iconfont = require('gulp-iconfont')
config = require('../../config').iconFonts
generateIconSass = require('./generateIconSass')
gulp.task 'iconFont', ->
  gulp.src(config.src).pipe(iconfont(config.options)).on('codepoints', generateIconSass).pipe gulp.dest(config.dest)
