util = require '../../util.js'
Config = React.createClass
  render: ->
    settings = this.props.settings || {}
    settings.channelCleaner = settings.channelCleaner || {}
    <div>
      <p>最大リレー数{settings.maxRelays}</p>
      <p>チャンネルごとの最大リレー数{settings.maxRelaysPerChannel}</p>
      <p>直下最大リレー数{settings.mexDirects}</p>
      <p>チャンネルごとの直下最大リレー数{settings.maxDirectsPerChannel}</p>
      <p>最大上り帯域{settings.maxUpstreamRate}</p>
      <p>チャンネルごとの最大上り帯域{settings.maxUpstreamRatePerChannel}</p>
      <p>チャンネル切断方式{settings.channelCleaner.mode}</p>
      <p>チャンネル切断猶予時間{util.format_time(settings.channelCleaner.inactiveLimit / 1000)}</p>
    </div>

module.exports = Config
