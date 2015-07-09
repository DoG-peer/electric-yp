Table = mui.Table
List = mui.List
ListItem = mui.ListItem
IconButton = mui.IconButton
FontIcon = mui.FontIcon
util = require '../../util.js'
# 接続しているチャンネル・リレー
# 自分の配信のリレー
# TODO: リレー情報の表示
# TODO: Tableのチェックボックスの削除
Relay = React.createClass
  disconnect: (id) ->
    -> console.log id

  render: ->
    channels = this.props.channels || []
    channelConnections = this.props.channelConnections || []
    listners = this.props.listenrs || []
    that = this
    rowData = channels.map (ch) ->
      disconnect:
        content:
          <IconButton onClick={that.disconnect(ch.channelId)}>
            <FontIcon className="icon-cross" color="#00bcd4" />
          </IconButton>
      name:
        content:
          <div>
            <p><a href={ch.info.url}>{ch.info.name}</a></p>
            <p>{ch.info.genre}</p>
          </div>

      status:
        content:
          <div>
           <p>{ch.status.totalDirects}/{ch.status.totalRelays}[{ch.status.localDirects}/{ch.status.localRelays}]</p>
           <p>{ch.status.status}</p>
          </div>
      desc:
        content:
          <div>
            <p>{ch.info.desc}</p>
            <p>{ch.info.comment}</p>
          </div>
      info:
        content:
          <div>
            <p>{ch.info.contentType}  {ch.info.bitrate}kbps</p>
            <p>{util.format_time ch.status.uptime}</p>
          </div>
    # console.log channelConnections, channels, listners

    headerCols =
      disconnect:
        content: "切断"
        tooltip: "チャンネルを切断する"
      name:
        content: "ch名"
        tooltip: "チャンネル名"
      desc:
        content: "詳細"
        tooltip: "配信詳細"
      status:
        content: "状態"
        tooltip: "状態"
      info:
        content: "情報"
        tooltip: "配信情報"
    colOrder = ["disconnect", "name", "status", "desc", "info"]
    <Table
      multiSelectable=true
      headerColumns={headerCols}
      rowData={rowData}
      columnOrder={colOrder}/>

###
      <p>{ch.status.isBroadcasting}</p>
      <p>{ch.status.isDirectFull}</p>
      <p>{ch.status.isReceiving}</p>
      <p>{ch.status.isRelayFull}</p>
      <p>{ch.status.source}</p>
###



module.exports = Relay
