## **※未経験時代**のポートフォリオ

# アプリ概要

### アプリ名
ラクカツ〜楽に楽しく部活動を〜

### 概要
担当競技経験が浅い or 未経験の中学校教職員による部活動負担の軽減を目的とした一元管理サービスです。<br>
主に部活動は"選手の指導"と”試合等のチーム運営"の 2 つに分けられます。これらの負担を軽くするために当サービス"ラクカツ"ではユーザ間で練習メニューの共有や試合相手募集、予定管理が行えます。
また、ユーザ間で直接やり取りできる DM 機能もあるため、学外での人脈形成を容易に行えます。
なお、レスポンジブ対応しておりますので、スマホからもご確認いただけます。<br>
**＊本サービスではサッカー部顧問を対象にしています。**

# 本番環境URL
https://www.rakukatsu.work/ (閉鎖済み)

<Basic認証><br>
username: tochi<br>
password: 2222

# 制作背景
「熱意とやる気だけじゃできなんだよな」と友人が漏らした一言がきっかけで当サービスの作成を考案・企画。<br>
昨今、教職員の長時間労働が問題となっている。特に"部活動への参加"は、こうした長時間労働の原因の1つとして挙げられる。<br>
実際、日本体育協会の調べでは、中学の部活動顧問の1日あたりの平均部活動勤務時間は平日が41分、休日が2時間10分となっており、10年前に比べて約2倍となっており、
一部の教職員への部活動に関するアンケートでは、校務と部活動の両立は難しいと考えている教員が半数近くおり、自身のワークライフバランスへの負担を感じている。
また、約4割の教員が担当している部活動競技への経験がなく、慣れない競技の指導や練習メニューの考案など別途業務が発生している現状もある。<br>
これらの事実を踏まえ、当サービス"ラクカツ"で、練習メニューの共有や練習試合などの募集を行える情報共有プラットフォームを設けることで、部活動負担の軽減に貢献したいと思い作成に踏み切った。

<br>
<br>

|教職員へのアンケート結果|教員の担当競技経験について|
|---|---|
|<img width="705" alt="スクリーンショット 2021-05-24 7 02 07" src="https://user-images.githubusercontent.com/81346474/119278142-67d6a500-bc5e-11eb-99af-db5793194be3.png">|<img width="834" alt="スクリーンショット 2021-05-24 7 04 02" src="https://user-images.githubusercontent.com/81346474/119278139-61e0c400-bc5e-11eb-86c8-07e58ef464a9.png">|

参考：https://www.mext.go.jp/sports/b_menu/shingi/013_index/shiryo/__icsFiles/afieldfile/2017/11/20/1398467_01_1.pdf　<br>
参考：https://www.mext.go.jp/sports/b_menu/shingi/013_index/shiryo/__icsFiles/afieldfile/2017/08/17/1386194_02.pdf



<br>


# 工夫した点

### 開発工程
 - ペルソナに該当する**現役教員へ実際にヒアリング**を行い、機能へ反映。
 - 実際の開発現場を想定して、機能ごとに細かくブランチを切って開発を進め、プルリクを最大限に活用。

### 機能ポイント

 - ペルソナが満足する十分な機能数の実装。
 - ユーザビリティを意識した実装（Ajax,リアルタイムDM等）。
 - 直感的に使い方が理解できるシンプルなデザイン。
 - モバイル端末からでも崩れないレスポンジブ対応。
 - 開発効率向上のためののDockerやCircleCIの導入。

<br>

# 機能一部紹介

### 練習内容の共有(トップページ)
[![Image from Gyazo](https://i.gyazo.com/33d905b3f426b1ed942e73b3db9785e9.gif)](https://gyazo.com/33d905b3f426b1ed942e73b3db9785e9)

- 練習詳細は入力文字数を表示。
- 複数のタグをつけることが可能。
- タグ付けを行う際に、インクリメンタルサーチが機能する。
- 複数枚の画像が投稿でき、選択した画像はプレビューとして表示される。

### リアルタイムDM機能
[![Image from Gyazo](https://i.gyazo.com/e28db3fd008cee3a9ccf314645b0648a.gif)](https://gyazo.com/e28db3fd008cee3a9ccf314645b0648a)

- ユーザはリアルタイムでのメッセージのやり取りが可能。
- 既読機能あり（ただし、リアルタイムでの表示されない）。

### カレンダー機能
[![Image from Gyazo](https://i.gyazo.com/3cc3facf9de60c1d68350804d003e687.gif)](https://gyazo.com/3cc3facf9de60c1d68350804d003e687)

- ユーザはマイページからカレンダーに予定を記入することが可能。
- ユーザは予定をクリックすると削除することが可能


<br>

# 機能一覧

- ユーザー登録、ログイン機能(devise)
- ゲストログイン機能
- ユーザ編集機能
- 練習内容投稿機能
  - 複数枚画像投稿機能
  - 複数タグ付機能
  - インクリメンタルサーチ機能(Ajax)
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


 
<br>

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
- CircleCi 自動テスト

<br>

# インフラ構成図

![AWS-infra](https://user-images.githubusercontent.com/81346474/119281603-44692580-bc71-11eb-9cc0-fc1eef024673.png)

<br>

# DB 設計
<img src="https://user-images.githubusercontent.com/81346474/117126305-8bcc6680-add5-11eb-8d7e-52ce81d2ab46.png" height="700">

<br>

# テスト

- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(system)

# ローカル環境で動かすためのコマンド

```:terminal
% mkdir rakukatsu
% cd rakukatsu 
% git clone https://github.com/tochisuke221/soccer_app.git
% docker-compose build
% docker-compose run web bundle exec rails db:create
% docker-compose run web bundle exec rails db:migrate
% docker-compose up -d

#テスト実行は上記コマンド実行後、以下のコマンドを実行
% docker-compose run web bundle exec rspec
```

# 今後の課題点
 - ユーザが使ってみたい！触ってみたいと思える魅力的なデザイン
 - さらなる機能の充実（例：練習試合の勝敗によるポイント機能など）
 - 動画などの投稿（例：ストーリー機能に近しいもの）
