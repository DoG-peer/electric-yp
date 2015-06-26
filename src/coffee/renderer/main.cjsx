React = require 'react'
ipc   = require 'ipc'

version_dom = null
ipc.on 'foo', (arg)->
  console.log arg
  if version_dom
    version_dom.setState
      version: arg[0] + arg[1]

VersionInfo = React.createClass
  foo: ->
    console.log "foo"
  getInitialState: ->
    {version: null}
  render: ->
    <div>{this.state.version || "確認中"}</div>

Timer = React.createClass
  getInitialState: ->
    {secondsElapsed: 0}
  tick: ->
    this.setState
      secondsElapsed: this.state.secondsElapsed + 1
    if this.state.secondsElapsed % 5 == 0
      ipc.send 'hoge', Math.random(10)
  componentDidMount: ->
    this.interval = setInterval this.tick, 1000
  componentWillUnmount: ->
    clearInterval this.interval
  render: ->
    <div>Seconds Elapsed: {this.state.secondsElapsed}</div>

window.onload = ->
  version_dom = React.render <VersionInfo />, document.getElementById 'version'

  React.render <Timer />, document.getElementById 'timer'
  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)
