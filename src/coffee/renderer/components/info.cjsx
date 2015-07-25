util = require '../../util.js'
List = mui.List
ListItem = mui.ListItem
Paper = mui.Paper
VersionInfo = React.createClass
  render: ->
    versionInfo = this.props.versionInfo || {}
    <h2>{versionInfo.agentName}</h2>

format_address = (pair) ->
  if pair
    "IP: #{pair[0]}, Port: #{pair[1]}"
  else
    "なし"

# 起動時間をリアルタイムにしたい
Status = React.createClass
  render: ->
    status = this.props.status || {}
    <div>
      <h2>情報</h2>
      <List>
        <ListItem>起動時間： {util.format_time(status.uptime)}</ListItem>
        <ListItem>ポート開放： {if status.isFirewalled then "未開放" else "OK"}</ListItem>
        <ListItem>リレーIP・ポート： {format_address status.globalRelayEndPoint}</ListItem>
        <ListItem>リレーIP・ポート（LAN）： {format_address status.localRelayEndPoint}</ListItem>
        <ListItem>視聴IP・ポート： {format_address status.globalDirectEndPoint}</ListItem>
        <ListItem>視聴IP・ポート（LAN）： {format_address status.localDirectEndPoint}</ListItem>
      </List>
    </div>
Plugins = React.createClass
  render: ->
    plugins = this.props.plugins || []
    <div>
      <h2>プラグイン</h2>
      <List>{
        plugins.map (plugin) ->
          <ListItem
            key={plugin.name}
            secondaryText={<p>{if plugin.isUsable then "利用可能" else "利用不可能"} {plugin.assembly.path} {plugin.assembly.version} </p>}
          >
            {plugin.name}
          </ListItem>
      }</List>
    </div>
module.exports =
  VersionInfo: VersionInfo
  Plugins: Plugins
  Status: Status
