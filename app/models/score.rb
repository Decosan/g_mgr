class Score < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
  acts_as_taggable
  
  validates :in_score, presence: true
  validates :out_score, presence: true
  validates :total_score, presence: true
  validates :in_put, presence: true
  validates :out_put, presence: true
  validates :total_put, presence: true

  scope :search, -> (search_params) do
    return if search_params.blank?

    play_day_from(search_params[:play_day_from])
      .play_day_to(search_params[:play_day_to])
      .course_id_is(search_params[:course_id])
      .total_score_from(search_params[:total_score_from])
      .total_score_to(search_params[:total_score_to])
  end
  
  scope :play_day_from, -> (from) { where('? <= play_day', from) if from.present? }
  scope :play_day_to, -> (to) { where('play_day <= ?', to) if to.present? }
  scope :course_id_is, -> (course_id) { where(course_id: course_id) if course_id.present? }
  scope :total_score_from, -> (score_from) { where('? <= total_score', score_from) if score_from.present? }
  scope :total_score_to, -> (score_to) { where('total_score <= ?', score_to) if score_to.present? }
end
