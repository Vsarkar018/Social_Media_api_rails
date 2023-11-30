class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :connections
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {minimum: 3 , maximum: 20}
  validates :email, presence: true, length: {minimum: 3 , maximum: 50}, format: {with: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/}, uniqueness: true
  validates :password, presence:true, length: {minimum: 8}
  has_many :active_relationships, class_name: 'Connection' , foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: 'Connection' , foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: following
  has_many :follower, through: :active_relationships, source: follower

  def follow(going_to_follow_user)
    following << going_to_follow_user
  end
  def unfollow(following_user)
    following.delete(following_user)
  end
end
