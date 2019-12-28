require 'rails_helper'

RSpec.describe 'Rainyテスト', type: :system do
  before do
    @user = FactoryBot.create(:user, email: "user@example.com", password: "password")
    visit start_users_path
    fill_in "メールアドレス", with: "user@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  describe 'Rainyスタート画面' do
    context 'ログインした場合' do
      it 'ユーザー一覧画面に遷移すること' do

        expect(page).to have_content 'Rainy スタート画面'
      end
    end
  end

  describe 'ユーザー一覧画面' do
    context '傘なしを選び、必要項目を入力して「利用を開始」ボタンを押した場合' do
      
      it '傘を持っているユーザー一覧ページに遷移すること' do
        visit start_users_path
        choose 'はい'
        fill_in 'あなたがいる場所を入力してください', with: '渋谷駅'
        fill_in 'あなたのアカウント名などを入力してください', with: 'テストちゃん'
        select '女', from: 'user_gender'
        select '20~26', from: 'user_age'
        
        click_on '利用を開始'
        
        expect(page).to have_content '傘を持っていないひとからのリクエスト一覧'
        expect(page).to have_content 'アカウント名'
        expect(page).to have_content '今いる場所'
        expect(page).to have_content '性別'
        expect(page).to have_content '年齢'
        expect(page).to have_content 'マイプロフィール'
      end
    end
  end

  describe 'ユーザー一覧画面' do
    context '傘ありを選び、必要項目を入力して「利用を開始」ボタンを押した場合' do
      
      it '傘を持っていないユーザー一覧ページに遷移すること' do
        visit start_users_path
        choose 'いいえ'
        fill_in 'あなたがいる場所を入力してください', with: '渋谷駅'
        fill_in 'あなたのアカウント名などを入力してください', with: 'テストちゃん'
        select '女', from: 'user_gender'
        select '20~26', from: 'user_age'
        
        click_on '利用を開始'
        
        expect(page).to have_content '傘を持っているひと一覧'
        expect(page).to have_content 'アカウント名'
        expect(page).to have_content '今いる場所'
        expect(page).to have_content '性別'
        expect(page).to have_content '年齢'
        expect(page).to have_content 'マイプロフィール'
      end
    end
  end

  describe 'マイプロフィール画面' do
    context '一覧画面で「マイプロフィール」を押した場合' do
      
      it 'マイプロフィールページに遷移すること' do
        visit users_path
        click_link 'マイプロフィール'
        
        expect(page).to have_content 'さんのプロフィール'
        expect(page).to have_content 'プロフィールを編集'
      end
    end
  end

  describe 'プロフィール編集画面' do
    context 'マイプロフィール画面で「プロフィールを編集」を押した場合' do
      
      it 'プロフィール編集画面ページに遷移すること' do
        visit users_path
        
        click_link 'マイプロフィール'
        click_link 'プロフィールを編集'
        
        expect(page).to have_content 'プロフィール編集画面'
        expect(page).to have_content '編集をキャンセルする'
      end
    end
  end

  describe 'ユーザー一覧画面' do
    context '傘ありを選び、必要項目を入力して「利用を開始」ボタンを押した場合' do
      before do
      @user2 = FactoryBot.create(
                                :user,
                                email: "aaaa@example.com",
                                password: "password",
                                have_umbrella: false,
                                area: "渋谷109",
                                name: "テストちゃん2号",
                                gender: "女",
                                age: "20~26"
                              )
      @user3 = FactoryBot.create(
                                :user,
                                email: "bbbb@example.com",
                                password: "password",
                                have_umbrella: false,
                                area: "渋谷109",
                                name: "テストちゃん3号",
                                gender: "女",
                                age: "20~26"
                              )
      #binding.pry
      end

      it '遷移先のページに傘を持っていないユーザーが表示されていること' do

        FactoryBot.create(:matching, follower_id: @user2.id, followed_id: @user.id)
        FactoryBot.create(:matching, follower_id: @user3.id, followed_id: @user.id)
        current_user = @user
        visit start_users_path

        choose 'はい'
        fill_in 'あなたがいる場所を入力してください', with: '渋谷駅'
        fill_in 'あなたのアカウント名などを入力してください', with: 'テストちゃん'
        select '女', from: 'user_gender'
        select '20~26', from: 'user_age'

        click_on '利用を開始'
        binding.pry
        expect(page).to have_content '傘を持っていないひとからのリクエスト一覧'
        expect(page).to have_content 'テストちゃん2号'
        expect(page).to have_content 'テストちゃん3号'
      end
    end
  end
end