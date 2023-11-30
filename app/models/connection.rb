class Connection < ApplicationRecord
  belongs_to :follower_id, class_name: 'User'
  belongs_to :following_id,  class_name: 'User'
  validates :follower_id, presence: true
  validates :following_id, presence: true
end
