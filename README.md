# README

# Rainy

## 概要
雨の日に人と人のつながりが生まれる
傘シェアリング&マッチングサービス

## コンセプト
傘の中の空間をシェアする新しい形の緩やかなマッチングサービス

## バージョン
Ruby 2.6.3  
Rails 5.2.4

## 機能一覧
- [ ] ログイン機能
- [ ] ユーザー登録機能
  - [ ] メールアドレス、名前、パスワードは必須
- [ ] パスワード再設定機能
- [ ] 現在地の入力と傘を持っているかどうかを選択する機能
- [ ] 傘を持っているユーザー一覧表示機能
  - [ ] アカウント名を表示
  - [ ] 今いる場所を表示
  - [ ] 性別を表示
  - [ ] おおよその年齢を表示 
- [ ] 傘を持っていないユーザー一覧表示機能
  - [ ] アカウント名を表示
  - [ ] 今いる場所を表示
  - [ ] 性別を表示
  - [ ] おおよその年齢を表示
- [ ] 傘を持っているユーザー検索機能
  - [ ] 今いる場所から傘を持っているユーザーを検索できる
  - [ ] 性別から傘を持っているユーザーを検索できる
  - [ ] 年齢から傘を持っているユーザーを検索できる
- [ ] ユーザー詳細表示機能
  - [ ] それぞれの一覧画面からユーザーの詳細を表示することができる
- [ ] リクエスト送信機能
  - [ ] 傘を持っていないユーザーは傘を持っているユーザーを1人選んでリクエストを送れる
- [ ] リクエスト承諾機能
  - [ ] 傘を持っているユーザーは傘を持っていない人からきたリクエスト一覧から一つだけ選んで承諾することができる
- [ ] リクエスト送信とリクエストのキャンセルはページ遷移なしで実行できる
- [ ] ページ遷移なしでリクエスト通知もしくはリクエスト承諾通知がくる
- [ ] マイプロフィール編集機能
  - [ ] 自分のアカウント名を編集することができる
  - [ ] 自分の性別を編集することができる
  - [ ] 自分の年齢を編集することができる
  - [ ] 自分の今いる場所を編集することができる
  - [ ] 自分のプロフィール文を編集することができる
- [ ] マッチング機能
  - [ ] 傘を持っていないユーザーからのリクエストを傘を持っているユーザーが承諾したらマッチングが完了する
- [ ] メッセージ送信機能
  - [ ] マッチングが完了したユーザー同士でメッセージを送り合うことができる
  - [ ] 新規メッセージをページ遷移なしで確認することができる
  - [ ] 自分のメッセージを削除することができる

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
