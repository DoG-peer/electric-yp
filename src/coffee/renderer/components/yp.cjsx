React = require 'react'
mui   = require 'material-ui'

List = mui.List
ListItem = mui.ListItem

# チャンネルリストとYPの設定
YP = React.createClass
  render: ->
    <List>{
      this.props.yellowPages.map (yellowPage) ->
        <ListItem key={yellowPage.name}>{yellowPage.name}</ListItem>
    }</List>

module.exports = YP
