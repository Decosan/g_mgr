class Score < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :commnets, dependent: :destroy
  has_many_attached :images
  
  validates :in_score, presence: true
  validates :out_score, presence: true
  validates :total_score, presence: true
  validates :in_put, presence: true
  validates :out_put, presence: true
  validates :total_put, presence: true
end
