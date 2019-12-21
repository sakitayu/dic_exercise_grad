# README

# Rainy

## 概要
シンプルにタイトルと記事内容を投稿することに特化したブログサービス
お気に入りとコメントを入れることができます。

## コンセプト
傘の中の空間をシェアする傘シェア&緩やかなマッチングサービス

## バージョン
Ruby 2.6.3
Rails 5.2.4

## 機能一覧
- [ ] ログイン機能
- [ ] ユーザー登録機能
  - [ ] メールアドレス、名前、パスワードは必須
- [ ] パスワード再設定機能
- [ ] ブログ一覧表示機能
  - [ ] コメント数を表示
  - [ ] お気に入り数を表示
- [ ] ブログ投稿機能
  - [ ] タイトルと記事内容は必須
- [ ] ブログ編集機能
- [ ] ブログ削除機能
  - [ ] ブログ編集とブログ削除は投稿者のみ実行可能
- [ ] ブログお気に入り機能
  - [ ] ブログのお気に入りについては1つのブログに対して1人1回しかできない
  - [ ] 自分自身のブログにはお気に入りできない
- [ ] コメント投稿機能
- [ ] コメント削除機能
- [ ] コメント編集機能
  - [ ] コメント編集とコメント削除はコメントした本人のみ可能
- [ ] コメント機能とお気に入り機能についてはページ遷移なしで実行できる

## カタログ設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vQRNOY03ypjIxTthuBAq_pKatH-w-vyCbr_It0KMQrlU1ReItaus1DUbHTiFMKFv4aEKWN6vssLElaC/pubhtml

## テーブル定義
https://docs.google.com/spreadsheets/d/e/2PACX-1vTQJC1TV38hLwTivc5LreMtPzjxj9OpqrFgVkYysZXHb1FttKg2MSbUP6r-U8-7noU52UHzQRxsY_SE/pubhtml

## 画面遷移図
https://docs.google.com/spreadsheets/d/e/2PACX-1vTLVdnF81Q_O93ebHGBfckJJhjXO4EKeHcYtX1mRxl3bk0ILjeOdI_pwmlmUeOI_aUBezdSoi_YJe71/pubhtml

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/e/2PACX-1vQW9UJIBgpQ7Ijd9oAv-vZYcxsO0X8r9bM9zWLJ4IOYV9aLLgRwe6T24Ae9gjOF-8gdesbHqiBhHtRi/pubhtml

## 使用予定Gem
* carrierwave
* mini_magick
* devise


# English Ver

# README

# Easy blog

## Overview
Blog service specialized in only posting titles and articles.
You can favorite blogs and make comments.

## Concept
Simple blog

## Version
Ruby 2.5.1
Rails 5.2.1

## Functions list
- [ ] Login function
- [ ] User registration function
  - [ ] Email address, name and password are required
- [ ] Password reset function
- [ ] Blog list display function
  - [ ] Show number of comments
  - [ ] Show number of favorites
- [ ] Blog post function
  - [ ] Title and article content is required
- [ ] Blog edit function
- [ ] Blog deletion function
  - [ ] Posters can only do blog edit and blog deletion
- [ ] Blog favorite function
  - [ ] You can favorite only once per one blog
  - [ ] You can't favorite your own blog
- [ ] Comment post function
- [ ] Comment deletion function
- [ ] Comment edit function
  - [ ] Only comment contributors can edit and delete comments
- [ ] The comment function and favorite function can be executed without page transition.

## Catalog design,Table_Definition,Screen transition diagram,,Wire frame
https://docs.google.com/spreadsheets/d/1V3sqZjVF5Oep0ek7hkLYGuIKSnhiTLqTbq46GpjP94E/edit#gid=0

## To be used Gem
* carrierwave
* mini_magick
* devise