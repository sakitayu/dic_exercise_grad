class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :active_matchings, foreign_key: 'follower_id', class_name: 'Matching', dependent: :destroy
  has_many :passive_matchings, foreign_key: 'followed_id', class_name: 'Matching', dependent: :destroy
  has_many :following, through: :active_matchings, source: :followed
  has_many :followers, through: :passive_matchings, source: :follower
  has_one :location, dependent: :destroy
  has_one :umbrella, dependent: :destroy
  has_one :profile, dependent: :destroy

  #enum gender: { "男": 1, "女": 2, "どちらでもない": 3 }
  #enum age: { "20~26": 1, "27~33": 2, "34~40": 3, "41~47": 4, "48~60": 5, "非公開": 6 }
  
  def follow!(other_user)
    active_matchings.create!(followed_id: other_user.id)
  end
  
  def following?(other_user)
    active_matchings.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_matchings.find_by(followed_id: other_user.id).destroy
  end
end
