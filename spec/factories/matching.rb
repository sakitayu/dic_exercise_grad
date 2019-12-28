FactoryBot.define do
  factory :matching do
    follower_id { 2 }
    followed_id { 1 }
  end
end