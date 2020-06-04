FactoryBot.define do
  factory :matching do
    
    association :followed, factory: :user  
    association :follower, factory: :user  

    # followed
    # follower

    follower_id { 1 }
    followed_id { 2 }
    # trait :with_followed do
    #   after(:build) do |matching|
    #     matching.followed = FactoryBot.build(:followed, 1)
    #   end
    # end


    # trait :with_follower do
    #   after(:build) do |matching|
    #     matching.follower = FactoryBot.build(:follower, 2)
    #   end
    # end
  end
end