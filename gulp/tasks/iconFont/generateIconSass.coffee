gulp = require('gulp')
config = require('../../config').iconFonts
swig = require('gulp-swig')
rename = require('gulp-rename')

module.exports = (codepoints, options) ->
  gulp.src(config.template).pipe(swig(data:
    icons: codepoints.map((icon) ->
      {
        name: icon.name
        code: icon.codepoint.toString(16)
      }
    )
    fontName: config.options.fontName
    fontPath: config.fontPath
    className: config.className
    comment: 'DO NOT EDIT DIRECTLY!\n  Generated by gulp/tasks/iconFont.js\n  from ' + config.template)).pipe(rename(config.sassOutputName)).pipe gulp.dest(config.sassDest)
  return
