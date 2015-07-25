List = mui.List
ListItem = mui.ListItem

# チャンネルリストとYPの設定
YP = React.createClass
  render: ->
    yps = this.props.yellowPages || []
    channels = this.props.ypChannels || []
    # 挙動が不安定
    <div>
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
