class Matching < ApplicationRecord
  after_create_commit { MatchingBroadcastJob.perform_later self }
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
  validates :follower_id, uniqueness: true
end
