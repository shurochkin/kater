gulp = require('gulp')
# Run this to compress all the things!
gulp.task 'production', [], ->
  # This runs only if the karma tests pass
  gulp.start [
    'jade'
    'images'
    'iconFont'
    'minifyCss'
    'uglifyJs'
  ]
  return
