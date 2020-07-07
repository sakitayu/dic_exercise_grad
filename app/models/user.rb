class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :image, ImageUploader
  has_many :active_matchings, foreign_key: 'follower_id', class_name: 'Matching', dependent: :destroy
  has_many :passive_matchings, foreign_key: 'followed_id', class_name: 'Matching', dependent: :destroy
  has_many :following, through: :active_matchings, source: :followed
  has_many :followers, through: :passive_matchings, source: :follower
  

  validates :have_umbrella, inclusion: {in: [true, false]}, on: :update
  validates :area, presence: true, length: { maximum: 25 }, on: :update
  validates :name, presence: true, length: { maximum: 11 }, on: :update
  validates :gender, presence: true, on: :update
  validates :age, presence: true, on: :update
  validates :introduction, length: { maximum: 225 }, on: :update

  enum gender: { "男": 1, "女": 2, "どちらでもない": 3 }
  enum age: { "20~26": 1, "27~33": 2, "34~40": 3, "41~47": 4, "48~60": 5, "非公開": 6 }
  
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
