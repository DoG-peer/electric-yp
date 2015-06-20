http = require 'http'

class PeerCastController
  constructor: () ->
    @hostname = "localhost"
    @port = 7144

  emit: (message) ->
    data = "{jsonrpc:\"2.0\",id:\"0\",method:\"#{message}\"}"
    options =
      hostname: @hostname
      port: @port
      path: '/api/1'
      method: 'POST'
      headers:
        'Content-length': data.length
        'x-requested-with': "XMLHttpRequest"
    console.log options
    req = http.request options, (res) ->
      #console.log res.statusCode
      #console.log res.headers
      res.setEncoding 'utf8'
      res.on 'data', (chunk) ->
        console.log chunk
    req.on 'err', (e) ->
      console.log "error #{e}"
    req.write data
    req.end()

module.exports = new PeerCastController()
