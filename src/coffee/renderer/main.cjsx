React = require 'react'
ipc   = require 'ipc'
mui   = require 'material-ui'
RaisedButton = mui.RaisedButton
ThemeManager = new mui.Styles.ThemeManager()


Root = React.createClass
  getInitialState: ->
    ipc.send 'init'
    {}
  childContextTypes:
    muiTheme: React.PropTypes.object
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
  render: ->
    <div>{(this.state.agentName) || "確認中"}
      <RaisedButton label="日本語" />
    </div>

VersionInfo = React.createClass
  getInitialState: ->
    {version: null}
  render: ->
    <div>this.state.version_in || "確認中"</div>
window.onload = ->
  root_dom = React.render <Root />, document.getElementById 'main'

  # getHogeHogeで取得した値は
  # 配列なら、hogeHogeの値として
  # オブジェクトなら、そのまま入れる
  # 特別なものあり

  ipc.on 'getBroadcastHistory', (arg) ->
    root_dom.setState
      channelConnections: arg

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
    console.log arg

  # TODO: 使われ方について要検証
  ipc.on 'getNewVersions', (arg) ->
    root_dom.setState arg

  # TODO: 使われ方について要検証
  ipc.on 'getNotificationMessages', (arg) ->
    root_dom.setState
      notificationMessages: arg

  ipc.on 'getPlugins', (arg) ->
    root_dom.setState
      plugins: arg

  ipc.on 'getSetting', (arg) ->
    root_dom.setState arg

  ipc.on 'getSourceStreams', (arg) ->
    root_dom.setState
      sourceStreams: arg
    console.log arg
  ipc.on 'getVersionInfo', (arg) ->
    root_dom.setState arg
    console.log arg

  ipc.on 'getStatus', (arg) ->
    root_dom.setState arg

  ipc.on 'getYellowPageProtocols', (arg) ->
    root_dom.setState
      yellowPageProtocols: arg
    console.log arg

  ipc.on 'getYellowPages', (arg) ->
    root_dom.setState
      yellowPages: arg
    console.log arg
  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)

  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)

