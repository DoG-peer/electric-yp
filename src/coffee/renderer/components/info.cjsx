List = mui.List
ListItem = mui.ListItem

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

module.exports =
  VersionInfo: VersionInfo
  Plugins: Plugins
  Status: Status
