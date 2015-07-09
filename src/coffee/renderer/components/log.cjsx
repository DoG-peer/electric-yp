# TODO: LogSettingの変更ボタン
Log = React.createClass
  render: ->
    <div>
      <p>{this.props.logLevel}</p>
      {
        this.props.logs.map (log) ->
          <p>{log}</p>
      }
    </div>
module.exports = Log
