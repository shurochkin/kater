gulp = require('gulp')
gulp.task 'default', [
  'compass'
  'images'
  'jade'
  'watch'
  'copyLibs'
  'copyFonts'
]
