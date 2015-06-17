
# PeerCastチャンネルビューワー

## 必要なもの
- 比較的最近のPeerCastStation


## 開発のヒント
- electron用のpackage.jsonはstatic/pacakge.json
- src/coffeeとstaticを編集して`gulp build`コマンドでbuild内に必要なファイルを準備。`npm start`で試せる。`gulp electron`で配布用のものができる（時間がかかる）
- build内のものは基本的に消される

## ロードマップ
- 最低限の機能をつける
- テストをどうにかしてする
- github-pagesなどを利用し、配布開始
- PeerCastStaionのGUIでできることを実現する

## 問題
- 日本語フォントをどうにかする
