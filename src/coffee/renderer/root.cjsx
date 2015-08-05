Tab = mui.Tab
Tabs = mui.Tabs

YP                      = require "./components/yp.js"
Relay                   = require "./components/relay.js"
Broadcast               = require "./components/broadcast.js"
Config                  = require "./components/config.js"
info                    = require "./components/info.js"
Plugins                 = info.Plugins
VersionInfo             = info.VersionInfo
Status                  = info.Status
Log                     = require "./components/log.js"
Help                    = require "./components/help.js"

Root = React.createClass
  getInitialState: ->
    ipc.send 'isAlive'
    {}
  childContextTypes:
    muiTheme: React.PropTypes.object
  getChildContext: ->
    muiTheme: ThemeManager.getCurrentTheme()
  render: ->
    <Tabs>
      <Tab label="YP">
        <YP
          yellowPages={this.state.yellowPages}
          yellowPageProtocols={this.state.yellowPageProtocols || []}
          ypChannels={this.state.ypChannels}
        />
      </Tab>
      <Tab label="リレー">
        <Relay
          channels={this.state.channels}
          channelConnections={this.state.channelConnections}
          listeners={this.state.listeners}
        />
      </Tab>
      <Tab label="配信">
        <Broadcast
          broadcastHistory={this.state.broadcastHistory || []}

        />
      </Tab>
      <Tab label="設定">
        <Config settings={this.state.settings || {}} />
      </Tab>
      <Tab label="情報">
        <VersionInfo
          versionInfo={this.state.versionInfo}
          newVersions={this.state.newVersions}
        />
        <Status
          status={this.state.status}
        />
        <Plugins plugins ={this.state.plugins || []} />
      </Tab>
      <Tab label="ログ">
        <Log
          logLevel={this.state.logLevel || 3}
          logs={this.state.logs || []}
        />
      </Tab>
      <Tab label="ヘルプ"><Help /></Tab>
    </Tabs>


module.exports = Root
