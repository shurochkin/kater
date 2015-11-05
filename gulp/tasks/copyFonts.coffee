gulp = require("gulp")
config = require("../config").fonts

gulp.task "copyFonts", [], ->
  gulp.src("#{config.src}/**").pipe(gulp.dest(config.dest));
  return