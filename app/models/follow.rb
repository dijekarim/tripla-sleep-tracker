class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :user

  validates :follower_id, uniqueness: { scope: :user_id }
end
