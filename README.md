# ShereTechtube
## サービス概要
YouTubeで見て、有用だった勉強動画の再生リストを作成し  
共有することで、信憑性の高い動画が見つけられる  
動画共有サービスです。  

## メインのターゲットユーザー
### 視聴者側
- 現在学習中で、動画で情報を探している人
- ついついYouTubeを見てしまう人
### 登録者側
- どの動画が有用だったか知見を共有したい人
- どの動画を見たか忘れてしまう人

## ユーザーが抱える課題
### 視聴者側
- 動画の数が多く、どの動画が理解しやすいか、見つけるのに時間がかかる。
- 動画の選択基準が登録者数と再生回数のため、動画の内容に信憑性があるかわからない。
- YouTubeで動画を見始めると、次々に見てしまい、時間を浪費してしまう。
### 登録者側
- どの動画が有用だったか共有する場がない。
- 動画で学んだ後、復習時にどの動画か忘れてしまい、再度検索することになる。

## 解決方法
- 登録された再生リストから動画を見る
- 再生リストを登録し、共有する

## 実装予定の機能
### ゲストログイン
- 登録された再生リストから動画を閲覧
- 動画の検索（タイトル名、タグ）
- 動画の推奨理由の閲覧
### ログイン後
- YouTubeで作成した再生リストの登録
 （登録内容：YouTubeの再生リスト、タイトル、推奨理由、カテゴリ、タグ）
- 登録されたリストへコメント
- 視聴したリストをTwitterで共有
- プロフィールに学習内容の記載
- 登録した再生リストをTwitter共有
- 違反しているリストの通報
### 管理ユーザー
- 規約から外れた再生リストの削除
- 登録された再生リスト内の動画を再読込み（APIに回数制限があるため）
### MVP後
- リストにおすすめ度を追加
- プロフィールにTwitter連携
- 当サイトからYouTubeの再生リストに動画を追加
- 登録された再生リスト内の動画を再読込みの自動化
ーンショット 2022-03-24 13 06 20" src="https://user-images.githubusercontent.com/93305003/159840224-8e9957d7-2194-4cfa-a844-54b35216e96b.png">

## なぜこのサービスを作りたいのか？
プログラミングの勉強の媒体の一つとしてyoutubeを使っています。　
動画を探すときに数が多いので、どの動画を見ると良いか悩みます。　
そのため、プログラマー同士で共有できる場があれば、
検索する時間の短縮や、有力な動画が集まるのではないかと考え、作成いたしました。

## 使用技術
< バックエンド >
・Ruby 3.0.0
・Rails  6.1.5
< フロントエンド >
・Vue.js 3.2.31
・Bluma(css)
< インフラ >
・heroku
・AWS S3
< その他特記 >
・gem google-api-client
・jsライブラリ lite-youtube-embed

## 画面遷移図
[figma](https://www.figma.com/file/aCfkhFpNcFb3WFQMDmtpth/kellyuka%2FShare-Larning-Youtube?node-id=0%3A1)

## ER図
[draw.io](https://drive.google.com/file/d/109XHxYjlhDbPLA9RzPEOrn1wvGzm3iY-/view?usp=sharing)

## スケジュール
企画〜技術調査：3/24〆切  
(YoutubeDataAPIで、チャンネルIDから再生リストの取得、再生リストIDから、動画の取得ができることを確認しました。)  
README〜ER図作成：3/31〆切  
メイン機能実装：4/30〆切  
β版をRUNTEQ内リリース(MVP):5/15 〆切  
本番リリース:5/31
