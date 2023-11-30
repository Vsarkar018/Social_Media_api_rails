class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :images, presence: true
end
