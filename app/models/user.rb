  class User < ApplicationRecord
    has_secure_password
    has_many :posts
    has_many :comments
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {minimum: 3 , maximum: 20}
    validates :email, presence: true, length: {minimum: 3 , maximum: 50}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	}, uniqueness: true
    validates :password, presence:true, length: {minimum: 8}
    has_many :this_user, class_name: 'Connection' , foreign_key: "follower_id", dependent: :destroy
    has_many :other_user, class_name: 'Connection' , foreign_key: "following_id", dependent: :destroy

    has_many :followers, through: :other_user, source: :followers # this is for many to many association and also query
    has_many :following, through: :this_user, source: :following  # is done using this association when we call the
                                                                    # user.followers or user.following
    # default_scope { select(column_names - ['password_digest']) }
    def follow(going_to_follow_user)
        connection = this_user.build(following: going_to_follow_user)
        connection.save
    end

    def unfollow(following_user)
        connection = this_user.find_by(following_id: following_user.id)
        connection.destroy if connection
    end

  end
