class Profile < ApplicationRecord
  belongs_to :user

  enum gender: { "男": 1, "女": 2, "どちらでもない": 3 }
  enum age: { "20~26": 1, "27~33": 2, "34~40": 3, "41~47": 4, "48~60": 5, "非公開": 6 }
end
