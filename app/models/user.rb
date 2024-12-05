class User < ApplicationRecord
  has_many :sleep_records
  has_many :follows, foreign_key: :follower_id
  has_many :followees, through: :follows, source: :user
  has_many :followers, foreign_key: :user_id, class_name: "Follow"
  has_many :followers_data, through: :followers, source: :follower

  validates :name, presence: true
end
