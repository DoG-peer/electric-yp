app           = require 'app'
BrowserWindow = require 'browser-window'
PeCaCtrl      = require './browser/peercast_controller'
ipc           = require 'ipc'


ipc.on 'hoge', (e, arg) ->
  PeCaCtrl.emitAsync "getVersionInfo"
    .then (val) ->
      e.sender.send 'foo', [arg + 1, JSON.parse(val).result.agentName]
    .catch (err) ->
      console.log err
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
