module.exports = {
  format_time: (t) ->
    d = Math.floor(t/(3600*24))
    h = Math.floor((t/3600) % 24)
    m = Math.floor((t/60) % 60)
    s = Math.floor(t % 60)
    "#{d}日#{h}時間#{m}分#{s}秒"
  rand: (n) ->
    Math.floor Math.random() * n
}
