util = require '../../util.js'
List = mui.List
ListItem = mui.ListItem
Paper = mui.Paper
VersionInfo = React.createClass
  render: ->
    versionInfo = this.props.versionInfo
    <Paper>{versionInfo.agentName}</Paper>

format_address = (pair) ->
  if pair
    "IP: #{pair[0]}, Port: #{pair[1]}"
  else
    "なし"

# 起動時間をリアルタイムにしたい
Status = React.createClass
  render: ->
    status = this.props.status
    <Paper>
      <p>起動時間： {util.format_time(status.uptime)}</p>
      <p>ポート開放： {if status.isFirewalled then "未開放" else "OK"}</p>
      <p>リレーIP・ポート： {format_address status.globalRelayEndPoint}</p>
      <p>リレーIP・ポート（LAN）： {format_address status.localRelayEndPoint}</p>
      <p>視聴IP・ポート： {format_address status.globalDirectEndPoint}</p>
      <p>視聴IP・ポート（LAN）： {format_address status.localDirectEndPoint}</p>
    </Paper>

Plugins = React.createClass
  render: ->
    <Paper>
      <List>{
        this.props.plugins.map (plugin) ->
          <ListItem
            key={plugin.name}
            secondaryText={<p>{if plugin.isUsable then "利用可能" else "利用不可能"} {plugin.assembly.path} {plugin.assembly.version} </p>}
          >
            {plugin.name}
          </ListItem>
      }</List>
    </Paper>

module.exports =
  VersionInfo: VersionInfo
  Plugins: Plugins
  Status: Status
