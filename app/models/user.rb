class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  # has_many :connections
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {minimum: 3 , maximum: 20}
  validates :email, presence: true, length: {minimum: 3 , maximum: 50}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	}, uniqueness: true
  validates :password, presence:true, length: {minimum: 8}
  # has_many :active_relationships, class_name: 'Connection' , foreign_key: "follower_id", dependent: :destroy
  # has_many :passive_relationships, class_name: 'Connection' , foreign_key: "following_id", dependent: :destroy
  # has_many :following, through: :passive_relationships, source: :following_id
  # has_many :followers, through: :active_relationships, source: :follower_id

  # def follow(going_to_follow_user)
  #   following << going_to_follow_user
  # end
  # def unfollow(following_user)
  #   following.delete(following_user)
  # end
end
