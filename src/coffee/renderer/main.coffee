window.onload = ->
  webview = document.querySelector 'webview'
  setFont = ->
    webview.insertCSS "*, .btn, ::-webkit-input-placeholder { font-family: Droid Sans Mono, Droid Sans Fallback;}"

  webview.addEventListener('dom-ready', setFont)
