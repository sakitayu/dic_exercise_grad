# README

# Raynee
![README用のRayneeロゴ](app/assets/images/rayneelogo4github.jpg "logo")

## アプリケーションURL
<h3>https://raynee.herokuapp.com</h3>

### アプリのQRコード▼
![README用のRayneeロゴ](app/assets/images/qr_raynee_heroku.png "qr_code")

## 概要
雨の日に人と人のつながりが生まれる傘シェアリング＆マッチングサービスです。<br>
傘を持っていないユーザーが自分のいる場所に近いユーザーを探してリクエストを送信し、<br>
相手から承諾されたのちに直接メッセージのやり取りができるようになります。<br>

### このサービスを作ろうと思ったきっかけ ☔︎
天気予報を確認しないまま傘を持たずに家を出てしまい、目的地に着く頃には土砂降りの雨。<br>
駅構内のコンビニでビニール傘を買ってしのいだものの、帰る頃には雨が止んでいた...<br>
<br>
こんな経験ありませんか？<br>
<br>
気づいたら家の玄関に新しいビニール傘が溜まっていく一方。<br>
もし、傘が必要な時に自分の近くにいる知らない人が相合傘してくれたら、どんなに素敵な世の中でしょうか。<br>
ふとそう思ったのがこのアプリを作るきっかけでした。<br>
<br>
傘を無駄に購入する必要なくちょとした出会いのきっかけにもなるサービス。<br>
<br>
それがRaynee☂️です。<br>

## バージョン
Ruby 2.6.3  
Rails 5.2.4

## 機能一覧
- ログイン機能
- ユーザー登録機能
- ユーザー検索機能
- プロフィール編集機能
- リクエスト承諾通知機能
- キャンセル通知機能
- マッチング機能
- メッセージ機能

## スクリーンショット
![README用のRayneeロゴ](app/assets/images/raynee_anime_large.gif "screenshot")

## 使い方
1. スマホとPC/Mac、もしくは2種類のブラウザを用意してそれぞれ以下のURLにアクセスします。
2. 【URL】https://raynee.herokuapp.com 【QRコード】![README用のRayneeロゴ](app/assets/images/qr_raynee_heroku.png "qr_code")
3. 一方を「サンプルユーザーA」でログインし、他方を「サンプルユーザーB」でログインします。
4. それぞれ「利用を開始」をクリックします。
5. サンプルユーザーAでログインした方のデバイスのユーザー一覧からサンプルユーザーBを見つけてクリックし、「この人にリクエストを送る」をクリックします。
6. サンプルユーザーBでログインした方のデバイスのリクエスト一覧にサンプルユーザーAが表示されるのでクリックし、「承諾する」をクリックするとメッセージ画面に移動します。
7. サンプルユーザーAでログインした方のデバイスにリクエストが承諾された旨の通知が表示されるので、この通知をクリックし、「お願いする」をクリックするとメッセージ画面に移動します。
8. マッチング完了です。それぞれのユーザーからメッセージを送り合ってみてください。

## カタログ設計
https://docs.google.com/spreadsheets/d/1jkdfB5QhGuiCdXwYa5FgVRzbw0I_XxRPcuP8uJx127I/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1rITo7L0AhSnEWOgwoJu_YKJhjzPJmmG3H8ITqfGD6tg/edit?usp=sharing

##  ER図

## 画面遷移図
https://docs.google.com/spreadsheets/d/16D7C_iYghqZb075Qxy524ciJA_B9JudhNZLSwvhayU0/edit?usp=sharing

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/1RfgUJXfSwmt3_wmU9-IuWb5Uab-FeYfrTjCGFCquHQo/edit?usp=sharing

## 使用Gem
ログイン系
* devise
* devise-i18n
* devise-i18n-views

画像投稿
* CarrierWave
* fog-aws

検索機能
* ransack

デバッグ
* pry-rails

テスト
* rspec-rails
* factory_bot_rails
