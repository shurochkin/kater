dest = "./build"
src = "./src"
app = "./src/app"
test = "./test"
libs = "./static/libs"
data = "./data"

module.exports =
  copyLibs:
    dest: dest
    libs: libs
  browserSync: server: baseDir: dest
  fonts:
    src: src + '/fonts'
    dest: dest + '/fonts'
  compass:
    src: src + '/sass/**/*.{sass,scss}'
    dest: dest
    settings:
    # Required if you want to use SASS syntax
    # See https://github.com/dlmanning/gulp-sass/issues/81
      sass: src + '/sass'
      css: dest
      sourceComments: "map"
      imagePath: "/images" # Used by the image-url helper
      require: ['susy', 'breakpoint', 'modular-scale']
  sass:
    src: src + '/sass/**/*.{sass,scss}'
    dest: dest
    settings:
      indentedSyntax: true
      imagePath: 'images'
  images:
    src: src + '/images/**'
    dest: dest + '/images'
  jade:
    indexSrc: app + '/index.jade'
    src: app + '/**/*.jade'
    dest: dest
  iconFonts:
    name: 'Gulp Starter Icons'
    src: src + '/icons/*.svg'
    dest: dest + '/fonts'
    sassDest: src + '/sass'
    template: './gulp/tasks/iconFont/template.sass.swig'
    sassOutputName: '_icons.sass'
    fontPath: 'fonts'
    className: 'icon'
    options:
      fontName: 'Post-Creator-Icons'
      appendCodepoints: true
      normalize: false
  browserify: bundleConfigs: [
    {
      entries: app + '/app.coffee'
      dest: dest
      outputName: 'app.js'
    }
    {
      entries: app + '/mobile.coffee'
      dest: dest
      outputName: 'mobile.js'
    }
  ]
  production:
    cssSrc: dest + '/*.css'
    jsSrc: dest + '/*.js'
    dest: dest
