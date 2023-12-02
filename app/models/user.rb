  class User < ApplicationRecord
    has_secure_password
    has_many :posts
    has_many :comments
    # has_many :connections
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {minimum: 3 , maximum: 20}
    validates :email, presence: true, length: {minimum: 3 , maximum: 50}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	}, uniqueness: true
    validates :password, presence:true, length: {minimum: 8}
    has_many :active_relationships, class_name: 'Connection' , foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: 'Connection' , foreign_key: "following_id", dependent: :destroy

    has_many :followers, through: :passive_relationships, source: :followers
    has_many :following, through: :active_relationships, source: :following

    def follow(going_to_follow_user)
        connection = active_relationships.build(following: going_to_follow_user)
        connection.save
    end

    def unfollow(following_user)
      active_relationships.find_by(following: following_user).destroy
    end

  end
