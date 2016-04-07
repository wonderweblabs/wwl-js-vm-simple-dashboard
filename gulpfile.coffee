gulp            = require('gulp')
browserifyInc   = require('browserify-incremental')
coffeeify       = require('coffeeify')
fs              = require('fs')
hamlify         = require('hamlify')
_               = require('lodash')
mkdirp          = require('mkdirp')
path            = require('path')
runSequence     = require('run-sequence').use(gulp)
source          = require('vinyl-source-stream')
buffer          = require('gulp-buffer')
changed         = require('gulp-changed')
notify          = require('gulp-notify')
rename          = require('gulp-rename')
rimraf          = require('gulp-rimraf')
sass            = require('gulp-sass')
sourcemaps      = require('gulp-sourcemaps')
util            = require('gulp-util')

gulp.task 'build', (cb) ->
  runSequence(
    'clean',
    'sass',
    'coffee-ensure-cache-file',
    'coffee',
    cb
  )

gulp.task 'watch', ->
  gulp.start('build')

  gulp.watch [
    'lib/**/*.coffee',
    'lib/**/*.hamlc',
    'build/**/*.coffee',
    'build/**/*.hamlc'
  ], ['coffee']

  gulp.watch [
    'css/**/*.sass',
    'build/**/*.sass',
  ], ['sass']

gulp.task 'clean', ->
  gulp.src([
    'bower_components/app',
    'build/**/*.css',
    'build/**/*.js',
    'build/webcomponents.html',
    'tmp',
  ], { read: false })
  .pipe(rimraf())


# ------------------------------------------------------------------------------------
# coffee

gulp.task 'coffee', ->
  stream = buildBrowserify(['build/index.coffee'], {
    debug:      true
    extensions: [".coffee", ".js", ".json"]
    cacheFile:  'tmp/browserify.json'
    paths: [
      'node_modules',
      'bower_components'
    ]
  })
  stream = appendError(stream, 'Coffee Error')
  stream = stream.pipe(source('index.js'))
  stream = stream.pipe(buffer())
  stream = stream.pipe(gulp.dest('build'))
  stream = appendNotify(stream, "Coffee", 'Done compiling')

gulp.task 'coffee-ensure-cache-file', ->
  if _.isString('tmp/browserify.json')
    try
      fs.accessSync('tmp/browserify.json', fs.R_OK)
    catch e
      mkdirp.sync(path.dirname('tmp/browserify.json'), { mode: (0o755 & (~process.umask())) })
      fs.writeFileSync('tmp/browserify.json', JSON.stringify({
        modules: {}
        packages: {}
        mtimes: {}
        filesPackagePaths: {}
        dependentFiles: {}
      }, null, 2))

# ------------------------------------------------------------------------------------
# sass

gulp.task 'sass', ->
  stream = gulp.src('build/index.sass')
  stream = appendError(stream, "Sass Error")
  stream = stream.pipe(changed('build', { extension: '.css' }))
  stream = stream.pipe(sourcemaps.init())
  stream = stream.pipe(sass({
    indentedSyntax:   true
    errLogToConsole:  true
    includePaths: [
      'css',
      'bower_components',
      'bower_components/bourbon/app/assets/stylesheets',
      'bower_components/neat/app/assets/stylesheets',
      'node_modules',
    ]
  }).on('error', sass.logError))
  stream = stream.pipe(sourcemaps.write())
  stream = stream.pipe(rename('index.css'))
  stream = stream.pipe(gulp.dest('build'))
  stream = appendNotify(stream, "Sass", 'Done compiling')


# ------------------------------------------------------------------------------------
# helper methods

appendError = (stream, title) ->
  stream.on 'error', (error) ->
    util.log.bind(util, "#{title} - #{error.toString()}")
    util.log(error)

    notify.onError({
      title:    title
      message:  error.toString()
    })(error)

    @emit('end')

appendNotify = (stream, title, message) ->
  stream.pipe(notify({
    title:    title
    message:  message
  }))

buildBrowserify = (files, config) ->
  stream = browserifyInc(files, _.extend(browserifyInc.args, config))
  stream = stream.transform(hamlify, { global: true })
  stream = stream.transform(coffeeify, {
    sourceMap:  true
    global:     true
  })
  stream = appendError(stream, 'Curo Coffee Error')
  stream = stream.bundle()
  stream