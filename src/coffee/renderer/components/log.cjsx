React = require 'react'
mui   = require 'material-ui'

Log = React.createClass
  render: ->
    <div>{this.props.logLevel}</div>
module.exports = Log
