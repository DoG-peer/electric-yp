List = mui.List
ListItem = mui.ListItem
RaisedButton = mui.RaisedButton
# チャンネルリストとYPの設定
YP = React.createClass
  update_channel_list: ->
    console.log "clicked"
    ipc.send 'update:channel_list'
  render: ->
    yps = this.props.yellowPages || []
    channels = this.props.ypChannels || []
    # 挙動が不安定
    <div>
      <RaisedButton label="更新" onClick={this.update_channel_list}/>
      <List>{
        yps.map (yp) ->
          <ListItem key={"YP::#{yp.name}"}>{yp.name}</ListItem>
      }</List>
      <List>{
        channels.map (ch) ->
          <ListItem key={"CH::#{ch.name}"}>{ch.name}</ListItem>
      }</List>
    </div>

module.exports = YP
