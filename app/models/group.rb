class Group < ApplicationRecord
  belongs_to :user
  has_many :user_groups, dependent: :destroy
  has_many :join_users, through: :user_groups, source: :user
end
