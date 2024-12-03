class User < ApplicationRecord
  has_many :sleep_records
  has_many :follows, foreign_key: :follower_id
  has_many :followees, through: :follows, source: :user

  validates :name, presence: true
end
