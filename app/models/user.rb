class User < ApplicationRecord
  has_many :scores, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :join_groups, through: :user_groups, source: :group
  has_many :user_groups, dependent: :destroy
  
  has_secure_password
  before_validation {email.downcase!}
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
