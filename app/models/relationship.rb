class Relationship < ApplicationRecord
  #this time, follower and followed is not a class. So explicitly direct a class_name: "User"
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
