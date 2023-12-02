class Connection < ApplicationRecord
  belongs_to :followers, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following,  class_name: 'User', foreign_key: 'following_id'
end
