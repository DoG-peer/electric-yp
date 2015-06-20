gulp      = require 'gulp'
plumber   = require 'gulp-plumber'
electron  = require 'gulp-electron'
coffee    = require 'gulp-coffee'
appJson   = null
packageJson = -> appJson = appJson || require './build/package.json'

gulp.task 'watch:coffee', ->
  gulp.watch './src/coffee/**/*.coffee', ['coffee'], ->
    gulp.src './src/coffee/**/*.coffee'
    .pipe plumber()
    .pipe coffee({bare: true})
    .pipe gulp.dest './build'
    console.log 'build:coffee'

gulp.task 'watch:static', ->
  gulp.watch './static/**', ['copy:static'], ->
    gulp.src './static/**'
    .pipe gulp.dest './build'
    console.log 'copy:static'

gulp.task 'coffee', ->
  gulp.src './src/coffee/**/*.coffee'
  .pipe plumber()
  .pipe coffee({bare: true})
  .pipe gulp.dest './build'

gulp.task 'electron', ->
  gulp.src ''
  .pipe electron
    src: './build'
    packageJson: packageJson()
    release: './release'
    cache: './cache'
    version: 'v0.28.2'
    rebuild: false
    platforms: ['win32-ia32', 'darwin-x64', 'linux-x64']
  .pipe gulp.dest ''

gulp.task 'copy:static', ->
  gulp.src './static/**'
  .pipe gulp.dest './build'

gulp.task 'build', ['coffee', 'copy:static']
gulp.task 'default', ['build']
gulp.task 'release', ['electron']
