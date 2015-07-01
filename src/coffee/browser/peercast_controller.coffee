http = require 'http'

class PeerCastController
  constructor: () ->
    @hostname = "localhost"
    @port = 7144

  emit: (message, params, callback) ->
    data = JSON.stringify
      jsonrpc: "2.0"
      id: "0"
      method: message
    if typeof(parms) == 'function'
      callback = params
      params = null
    if params
      data.params = params
    if callback == null
      callback = (v)->
        console.log v

    options =
      hostname: @hostname
      port: @port
      path: '/api/1'
      method: 'POST'
      headers:
        'Content-length': data.length
        'x-requested-with': "XMLHttpRequest"
    req = http.request options, (res) ->
      res.setEncoding 'utf8'
      res.on 'data', (chunk) ->
        console.log chunk
    req.on 'err', (e) ->
      console.log "error #{e}"
    setTimeout ->
      req.write data
      req.end()
    , 2000
    @

  emitAsync: (message, params) ->
    that = @
    new Promise (resolve, reject) ->
      data = JSON.stringify
        jsonrpc: "2.0"
        id: "0"
        method: message
      if typeof(parms) == 'function'
        callback = params
        params = null
      if params
        data.params = params
      if callback == null
        callback = (v)->
          console.log v

      options =
        hostname: that.hostname
        port: that.port
        path: '/api/1'
        method: 'POST'
        headers:
          'Content-length': data.length
          'x-requested-with': "XMLHttpRequest"
      req = http.request options, (res) ->
        res.setEncoding 'utf8'
        res.on 'data', (chunk) ->
          resolve JSON.parse(chunk).result
      req.on 'err', (e) ->
        reject e
      req.write data
      req.end()
      that

  # 例
  # emitParaell ["a", "i", "u", "e", "o"]
  # .forEach (x) ->
  #   x.process.then ・・・
  emitPararell: (array) ->
    that = @
    array.map (mes) ->
      message: mes
      process: that.emitAsync mes


module.exports = new PeerCastController()
