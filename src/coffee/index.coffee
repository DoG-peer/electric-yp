electron      = require 'electron'
app           = electron.app
BrowserWindow = electron.BrowserWindow
PeCaCtrl      = require "./browser/peercast_controller"
ipc           = electron.ipcMain

# PeerCastStaionが起動していることを確認する
ipc.on 'isAlive', (e, arg) ->
  PeCaCtrl.emit "getVersionInfo"
    .then (val) ->
      e.sender.send 'isAlive', true
    .catch (err) ->
      e.sender.send 'isAlive', false #TODO: 別方式の方がいいかも

ipc.on 'init', (e, arg) ->
  # TODO: きちんと書く
  # PeCaCtrl.emitPararell ["getBroadcastHistory", "getChannelConnections", "getChannels", "getContentReaders", "getListeners", "getLogSettings", "getNewVersions", "getPlugins", "getVersionInfo", "getStatus", "getSourceStreams", "getSettings", "getYellowPageProtocols", "getYellowPages", "getYPChannels"]
  PeCaCtrl.emitPararell [
    "getBroadcastHistory",
    "getChannelConnections",
    "getChannels",
    "getContentReaders",
    "getListeners",
    "getLogSettings",
    "getNewVersions",
    "getPlugins",
    "getVersionInfo",
    "getStatus",
    "getSourceStreams",
    "getSettings",
    "getYellowPageProtocols",
    "getYellowPages",
    "getYPChannels"]
    .forEach (p) ->
      p.process.then (val) ->
        e.sender.send p.message, val
      .catch (err) ->
        console.log err, p

ipc.on 'update:channel_list', (e, arg) ->
  PeCaCtrl.emit 'updateYPChannels'
    .then (val) ->
      e.sender.send 'getYPChannels', val
    .catch (err) ->
      console.log err, 'Failed for updating channnel list.'
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
  mainWindow.loadURL "file://#{__dirname}/renderer/index.html"
  mainWindow.on 'close', ->
    mainWindow = null
