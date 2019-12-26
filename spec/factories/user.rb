FactoryBot.define do
  factory :user do
    email { "test_user@test.co.jp" }
    password { "12345678" }
    confirmed_at { Date.today }
    have_umbrella { false }
    area { "渋谷駅" }
    name { "テストユーザー" }
    gender { "男" }
    age { "20~26" }
  end
end