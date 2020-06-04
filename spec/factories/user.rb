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

  #   active_matchings {[
  #     FactoryBot.build(:following, user: nil)
  #   ]}

  #   passive_matchings {[
  #     FactoryBot.build(:followers, user: nil)
  #   ]}
  end

  

  # factory :group do
  #   users {[
  #   FactoryBot.build(:user, group: nil)
  #   ]}
  # end

  # trait :user_with_matchings do
  #   after(:build) do |user|  # after(:build)とした場合、createの場合もcallbackが走る
  #     user.active_matchings << build(:matching)
  #     user.passive_matchings << build(:matching)
  #   end
  # end



  factory :followed, class: User do
    email { "test_user2@test.co.jp" }
    password { "12345678" }
    confirmed_at { Date.today }
    have_umbrella { false }
    area { "渋谷駅" }
    name { "テストユーザー" }
    gender { "男" }
    age { "20~26" }
  end

  factory :follower, class: User do
    email { "test_user3@test.co.jp" }
    password { "12345678" }
    confirmed_at { Date.today }
    have_umbrella { false }
    area { "渋谷駅" }
    name { "テストユーザー" }
    gender { "男" }
    age { "20~26" }
  end

  # factory :active_matchings do
  #   users {[
  #   FactoryBot.build(:user, active_matchings: nil)
  #   ]}
  # end
  
end