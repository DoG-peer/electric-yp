React = require 'react'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()
ipc   = require 'ipc'
mui   = require 'material-ui'
window.React = React
root_dom = null
Table = mui.Table
Tab = mui.Tab
Tabs = mui.Tabs
LeftNav = mui.LeftNav
List = mui.List
ListItem = mui.ListItem
Menu = mui.Menu
RaisedButton = mui.RaisedButton
ThemeManager = new mui.Styles.ThemeManager()
ThemeManager.contentFontFamily = "Roboto, sans-serif, Droid Sans Mon, Droid Sans Fallback"

Root = React.createClass
  getInitialState: ->
    ipc.send 'init'
    {}
  childContextTypes:
    muiTheme: React.PropTypes.object
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
  render: ->
    <Tabs>
      <Tab label="YP">
        <YP
          yellowPages={this.state.yellowPages || []}
          yellowPageProtocols={this.state.yellowPageProtocols || []}
        />
      </Tab>
      <Tab label="リレー">
        <Relay
          channels={this.state.channels || []}
          channelConnections={this.state.channelConnections || []}
          listeners={this.state.listeners || []}
        />
      </Tab>
      <Tab label="配信"><Broadcast /></Tab>
      <Tab label="設定"><Config />

      </Tab>
      <Tab label="情報">
        <VersionInfo
          versionInfo={this.state.versionInfo || {}}
          newVersions={this.state.newVersions || []}
        />
        <Status status={this.state.status || {}} />
        <Plugins plugins ={this.state.plugins || []} />
      </Tab>
      <Tab label="ログ">
        <Log
          logLevel={this.state.logLevel || 3}
          logs={this.state.logs || []}
        />
      </Tab>
      <Tab label="ヘルプ"><Help /></Tab>
    </Tabs>

Plugins = React.createClass
  render: ->
    <List>{
      this.props.plugins.map (plugin) ->
        <ListItem
          key={plugin.name}
          secondaryText={<p>{if plugin.isUsable then "利用可能" else "利用不可能"} {plugin.assembly.path} {plugin.assembly.version} </p>}
        >
          {plugin.name}
        </ListItem>
    }</List>

# チャンネルリストとYPの設定
YP = React.createClass
  render: ->
    <List>{
      this.props.yellowPages.map (yellowPage) ->
        <ListItem key={yellowPage.name}>{yellowPage.name}</ListItem>
    }</List>

# 接続しているチャンネル・リレー
# 自分の配信のリレー
Relay = React.createClass
  render: ->
    <div>RelayRelayRelay</div>
Broadcast = React.createClass
  render: ->
    <div>はよ配信</div>
Config = React.createClass
  render: ->
    <div>Config</div>
VersionInfo = React.createClass
  render: ->
    versionInfo = this.props.versionInfo
    <p>{versionInfo.agentName}</p>
Status = React.createClass
  render: ->
    status = this.props.status
    <div>
    <h1>Info</h1>
    <p>{status.uptime}</p>
    <p>{status.isFirewalled}</p>
    <p>{status.globalRelayEndPoint}</p>
    <p>{status.globalDirectEndPoint}</p>
    <p>{status.localRelayEndPoint}</p>
    <p>{status.localDirectEndPoint}</p>
    </div>
Log = React.createClass
  render: ->
    <div>{this.props.logLevel}</div>

Help = React.createClass
  render: ->
    <div>たすけてー</div>











window.onload = ->
  root_dom = React.render <Root />, document.getElementById 'main'

  # getHogeHogeで取得した値を
  # hogeHogeの値としてstateに格納

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

  ipc.on 'getSetting', (arg) ->
    root_dom.setState
      setting: arg

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

  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)

  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)

