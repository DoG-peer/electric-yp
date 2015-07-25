React = require 'react'
ipc   = require 'ipc'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

mui   = require 'material-ui'
ThemeManager = new mui.Styles.ThemeManager()
ThemeManager.contentFontFamily = "Roboto, sans-serif, Droid Sans Mon, Droid Sans Fallback"

root_dom = null
Root = require "./root.js"

window.onload = ->
  root_dom = React.render <Root />, document.getElementById 'main'

  # getHogeHogeで取得した値を
  # hogeHogeの値としてstateに格納

  ipc.on 'isAlive', (arg) ->
    if arg
      ipc.send 'init'
    else
      setTimeout ->
        ipc.send 'isAlive'
      , 10000

  ipc.on 'getBroadcastHistory', (arg) ->
    root_dom.setState
      broadcastHistory: arg

  ipc.on 'getChannelConnections', (arg) ->
    root_dom.setState
      channelConnections: arg

  # TODO: 特別な用法
  ipc.on 'getChannelChannelInfo', (arg) ->
    console.log arg

  # TODO: 特別な用法
  ipc.on 'getChannelOutputs', (arg) ->
    console.log arg

  # TODO: 特別な用法
  ipc.on 'getChannelRelayTree', (arg) ->
    console.log arg
  # TODO: 特別な用法
  ipc.on 'getChannelStatus', (arg) ->
    console.log arg

  ipc.on 'getChannels', (arg) ->
    root_dom.setState
      channels: arg

  ipc.on 'getContentReaders', (arg) ->
    root_dom.setState
      contentReaders: arg

  ipc.on 'getListeners', (arg) ->
    root_dom.setState
      listners: arg
  # TODO
  ipc.on 'getLog', (arg) ->
    console.log arg

  # TODO: 要検証
  ipc.on 'getLogSettings', (arg) ->
    root_dom.setState
      logLevel: arg.level

  # TODO: 使われ方について要検証
  ipc.on 'getNewVersions', (arg) ->
    root_dom.setState
      newVersions: arg

  # TODO: 使われ方について要検証
  ipc.on 'getNotificationMessages', (arg) ->
    root_dom.setState
      notificationMessages: arg

  ipc.on 'getPlugins', (arg) ->
    root_dom.setState
      plugins: arg

  ipc.on 'getSettings', (arg) ->
    root_dom.setState
      settings: arg

  ipc.on 'getSourceStreams', (arg) ->
    root_dom.setState
      sourceStreams: arg

  ipc.on 'getVersionInfo', (arg) ->
    root_dom.setState
      versionInfo: arg

  ipc.on 'getStatus', (arg) ->
    root_dom.setState
      status: arg

  ipc.on 'getYellowPageProtocols', (arg) ->
    root_dom.setState
      yellowPageProtocols: arg

  ipc.on 'getYellowPages', (arg) ->
    root_dom.setState
      yellowPages: arg

  ipc.on 'getYPChannels', (arg) ->
    root_dom.setState
      ypChannels: arg
  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)
