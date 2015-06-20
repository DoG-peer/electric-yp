app           = require 'app'
BrowserWindow = require 'browser-window'
PeCaCtrl      = require './browser/peercast_controller'

console.log PeCaCtrl.emit "getVersionInfo"

#require 'crash-reporter'
#.start()

mainWindow = null

app.on 'window-all-closed', ->
  if process.platform != 'darwin'
    app.quit()

app.on 'ready', ->
  mainWindow = new BrowserWindow
    "width":  800
    "height": 600
  mainWindow.loadUrl "file://#{__dirname}/index.html"
  mainWindow.on 'close', ->
    mainWindow = null
