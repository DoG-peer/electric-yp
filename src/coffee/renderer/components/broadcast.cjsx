DropDownMenu = mui.DropDownMenu
SelectField = mui.SelectField
TextField = mui.TextField
# ソース、ストリームURL、ビットレート、ストリームタイプ
# YP、チャンネル名、ジャンル、概要、コメント、URL、トラック情報
Broadcast = React.createClass
  getInitialState: ->
    selectValue: 0
    source: "RTMP source"
    streamURL: "rtmp://localhost/live/livestream"
    bitrate: ""
    streamType: "FLV"
    YP: ""
    name: "なまえ"
    genre: ""
    desc: ""
    comment: ""
    url: ""
    track_title: ""
    track_album: ""
    track_creator: ""
    track_genre: ""
    track_url: ""

  _handleSelectValueChange: ->
  _handleInputChange: (key) ->
    that = this
    (e) ->
      new_value = {}
      new_value[key] = e.target.value
      that.setState new_value
  render: ->
    broadcastHistory = this.props.broadcastHistory || []
    menuItems = broadcastHistory.map (h, i) ->
      payload: (i+1).toString()
      text: h.description[0..5]
    # TODO: SelectField問題 DropDown問題
    # https://github.com/callemall/material-ui/issues/805
    # muiのバグっぽい
    <div>
      <TextField floatingLabelText="チャンネル名"
        value={this.state.name}
        onChange={this._handleInputChange("name")} />
      <TextField floatingLabelText="ビットレート"
        value={this.state.bitrate}
        onChange={this._handleInputChange("bitrate")} />
      <TextField floatingLabelText="YP"
        value={this.state.YP}
        onChange={this._handleInputChange("YP")} />
      <TextField floatingLabelText="genre"
        value={this.state.genre}
        onChange={this._handleInputChange("genre")} />
      <TextField floatingLabelText="desc"
        value={this.state.desc}
        onChange={this._handleInputChange("desc")}
        fullWidth=true />
      <TextField floatingLabelText="comment"
        value={this.state.comment}
        onChange={this._handleInputChange("comment")}
        fullWidth=true />
      <TextField floatingLabelText="url"
        value={this.state.url}
        onChange={this._handleInputChange("url")}
        fullWidth=true />
      <TextField floatingLabelText="track_title"
        value={this.state.track_title}
        onChange={this._handleInputChange("track_title")} />
      <TextField floatingLabelText="track_album"
        value={this.state.track_album}
        onChange={this._handleInputChange("track_album")} />
      <TextField floatingLabelText="track_creator"
        value={this.state.track_creator}
        onChange={this._handleInputChange("track_creator")} />
      <TextField floatingLabelText="track_genre"
        value={this.state.track_genre}
        onChange={this._handleInputChange("track_genre")} />
      <TextField floatingLabelText="track_url"
        value={this.state.track_url}
        onChange={this._handleInputChange("track_url")} />
    </div>
###

  <DropDownMenu menuItems={menuItems} menuItemStyle={{backgroundcolor: "black"}}/>
    <SelectField
      defaultValue=1
      value={this.state.selectValue}
      onChange={this._handleSelectValueChange}
      menuItems={menuItems}
      hintText="hint"
      floatingLabelText="履歴"
      fullWidth=true
    />
###
# {
#  broadcastHistory.map (h, i) ->
#    <p key={i}>{h.description}</p>
#}
module.exports = Broadcast
