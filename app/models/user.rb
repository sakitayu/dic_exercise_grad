class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :active_matchings, foreign_key: 'follower_id', class_name: 'Matching', dependent: :destroy
  has_many :passive_matchings, foreign_key: 'followed_id', class_name: 'Matching', dependent: :destroy
  has_many :following, through: :active_matchings, source: :followed
  has_many :followers, through: :passive_matchings, source: :follower
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :sender_id, scope: :recipient_id
  scope :between, -> (sender_id,recipient_id) do
    where(["(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id ,recipient_id, recipient_id, sender_id])
  end

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
