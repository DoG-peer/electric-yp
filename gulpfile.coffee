'use strict'

gulp        = require 'gulp'
$           = require('gulp-load-plugins')()
_           = require 'lodash'
fs          = require 'fs'
plumber     = require 'gulp-plumber'
coffee      = require 'gulp-coffee'
cjsx        = require 'gulp-cjsx'
packageJson = require './package.json'

electron    = require('electron-connect').server.create
  path: './build'
packager    = require 'electron-packager'

gulp.task 'cjsx', ->
  gulp.src './src/coffee/**/*.cjsx'
  .pipe plumber()
  .pipe cjsx({bare: true})
  .pipe gulp.dest './build'

gulp.task 'coffee', ->
  gulp.src './src/coffee/**/*.coffee'
  .pipe plumber()
  .pipe coffee({bare: true})
  .pipe gulp.dest './build'

gulp.task 'copy:static', ->
  gulp.src './static/**/*'
  .pipe gulp.dest './build'

gulp.task 'copy:dependencies', ->
  dependencies = []
  for name of packageJson.dependencies
    dependencies.push name
  gulp.src "node_modules/{#{dependencies.join ','}}/**/*"
    .pipe gulp.dest './build/node_modules'

gulp.task 'packageJson', ['copy:dependencies'], (done) ->
  json = _.cloneDeep(packageJson)
  json.main = 'index.js'
  fs.writeFile './build/package.json', JSON.stringify(json), (err) ->
    done()

gulp.task 'package', ['win32', 'darwin', 'linux'].map (platform) ->
  taskName = "package:#{platform}"
  gulp.task taskName, ['build'], (done) ->
    packager
      dir: './build'
      name: 'ElectricYP'
      arch: 'x64'
      platform: platform
      out: "./release/#{platform}"
      version: "0.28.3"
    , (err) ->
      done()
  taskName

gulp.task 'serve', ['coffee', 'cjsx', 'copy:static'], () ->
  electron.start()
  gulp.watch ['src/coffee/**/*.coffee'], ['coffee']
  gulp.watch ['src/coffee/**/*.cjsx'], ['cjsx']
  gulp.watch ['static/**/*'], ['copy:static']
  gulp.watch ['build/index.js', 'build/browser/**/*.js', 'build/renderer/index.html'], electron.restart
  gulp.watch ['build/**/*.css', 'build/renderer/**/*.js'], electron.reload


gulp.task 'build', ['cjsx', 'coffee', 'copy:static', 'packageJson']
gulp.task 'default', ['build']
gulp.task 'release', ['package']
