app           = require 'app'
BrowserWindow = require 'browser-window'
PeCaCtrl      = require "./browser/peercast_controller"
ipc           = require 'ipc'

# PeerCastStaionが起動していることを確認する
ipc.on 'isAlive', (e, arg) ->
  PeCaCtrl.emit "getVersionInfo"
    .then (val) ->
      e.sender.send 'isAlive', true
    .catch (err) ->
      e.sender.send 'isAlive', false #TODO: 別方式の方がいいかも

ipc.on 'init', (e, arg) ->
  # TODO: きちんと書く
  PeCaCtrl.emitPararell ["getBroadcastHistory", "getChannelConnections", "getChannels", "getContentReaders", "getListeners", "getLogSettings", "getNewVersions", "getPlugins", "getVersionInfo", "getStatus", "getSourceStreams", "getSettings", "getYellowPageProtocols", "getYellowPages"]
    .forEach (p) ->
      p.process.then (val) ->
        e.sender.send p.message, val
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
    "width":  400
    "height": 300
  mainWindow.loadUrl "file://#{__dirname}/renderer/index.html"
  mainWindow.on 'close', ->
    mainWindow = null
