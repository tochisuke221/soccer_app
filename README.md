# ラクカツ概要

担当競技経験が浅い or 未経験の中学校教職員による部活動負担の軽減を目的とした一元管理サービスです。<br>
主に部活動は"選手の指導"と”試合等のチーム運営"の 2 つに分けられます。これらの負担を軽くするために当サービス"ラクカツ"ではユーザ間で練習メニューの共有や試合相手募集、予定管理が行えます。
また、ユーザ間で直接やり取りできる DM 機能もあるため、学外での人脈形成を容易に行えます。
なお、レスポンジブ対応しておりますので、スマホからもご確認いただけます。


# URL
https://www.rakukatsu.work/

username: tochi<br>
password: 2222

<サイト一部紹介><br>
<img src="https://user-images.githubusercontent.com/81346474/118359027-6ea94c00-b5bc-11eb-8671-b7165422d18f.png" width="700">
<img src="https://user-images.githubusercontent.com/81346474/118359033-71a43c80-b5bc-11eb-8855-0960a5ef9638.png" width="700">

# 機能一覧

- ユーザー登録、ログイン機能(devise)
- ゲストログイン機能
- ユーザ編集機能
- 練習内容投稿機能
  - 複数枚画像投稿機能
  - 複数タグ付機能
  - インクリメンタルリサーチ機能(Ajax)
  - 文字数カウント機能(Ajax)
- 画像プレビュー機能
- 投稿編集機能
- 投稿削除機能
- スライドショー機能(Slick)
- 試合募集機能
- 試合削除機能
- 試合申し込み機能
- いいね機能(Ajax)
  - いいね数ランキング機能
  - 自己いいね一覧機能
  - いいね数表示機能
- コメント機能(Ajax)
  - コメント数表示機能
- フォロー機能(Ajax)
  - フォロー一覧機能
  - フォロワー一覧機能
- ページネーション機能(kaminari)
- パンくずリスト機能(gretel)
- 検索機能(複数ワード対応)
- 通知機能
  - コメント通知
  - フォロー通知
  - いいね通知
- リアルタイム DM 機能（ActionCable）
  - 未読件数表示機能
  - 既読表示機能
- カレンダー機能(SimpleCalendar ※モバイルの場合、表として表示)
  - 予定追加機能
- レスポンシブ対応
  - ハンバーガーメニュー等

# 使用技術

- Ruby 2.6.5
- Ruby on Rails 6.0.0
- MySQL 5.6
- Nginx
- AWS
  - VPC
  - EC2
  - RDS
  - Route53
  - ALB
  - ACM
- RSpec
- Docker/Docker-compose
- CircleCi CI/CD　（現在構築中）

# インフラ構成図
![AWS](https://user-images.githubusercontent.com/81346474/118099142-ca82a200-b40f-11eb-9ae9-9138af3bef06.png)

# DB 設計
<img src="https://user-images.githubusercontent.com/81346474/117126305-8bcc6680-add5-11eb-8d7e-52ce81d2ab46.png" width="700">
# テスト

- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(system)
