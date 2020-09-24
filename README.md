# README

# Raynee
![README用のRayneeロゴ](app/assets/images/rayneelogo4github.jpg "logo")

## アプリケーションURL
https://raynee.herokuapp.com

## 概要
雨の日に人と人のつながりが生まれる傘シェアリング＆マッチングサービスです。<br>
傘を持っていないユーザーが自分のいる場所に近いユーザーを探してリクエストを送信し、<br>
相手から承諾されたのちに直接メッセージのやり取りができるようになります。<br>

### このサービスを作ろうと思ったきっかけ ☔︎
天気予報を確認しないまま傘を持たずに家を出てしまい、目的地に着く頃には土砂降りの雨。<br>
駅構内のコンビニでビニール傘を買ってしのいだものの、帰る頃には雨が止んでいた...<br>
<br>
そんな経験ありませんか？<br>
<br>
そんなことを繰り返していくうちに家の玄関にはビニール傘が無駄に増える一方。<br>
もし傘が必要な時に、自分の近くにいる知らない人が相合傘してくれたら素敵な世の中になるのになあ...<br>
と思ったのがこのアプリを作るきっかけでした。<br>
<br>
傘を無駄に買う必要なく誰かの出会いのきっかけにもなるサービス。<br>それがRaynee☂️です。<br>

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

## カタログ設計
https://docs.google.com/spreadsheets/d/1jkdfB5QhGuiCdXwYa5FgVRzbw0I_XxRPcuP8uJx127I/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1rITo7L0AhSnEWOgwoJu_YKJhjzPJmmG3H8ITqfGD6tg/edit?usp=sharing

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

検索機能
* ransack

デバッグ
* pry-rails

テスト
* rspec-rails
* factory_bot_rails
