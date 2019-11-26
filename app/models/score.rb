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

  scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
    return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

    name_kana_like(search_params[:name_kana])
      .play_day_from(search_params[:play_day_from])
      .play_day_to(search_params[:play_day_to])  #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
  end

  scope :name_kana_like, -> (name_kana) { where('name_kana LIKE ?', "%#{name_kana}%") if name_kana.present? }  #scopeを定義。
  scope :play_day_from, -> (from) { where('? <= play_day', from) if from.present? }
  scope :play_day_to, -> (to) { where('play_day <= ?', to) if to.present? }
    #日付の範囲検索をするため、fromとtoをつけている
    #scope :メソッド名->(引数){ SQL文 }
    #if 引数.present?をつけることで、検索フォームに値がない場合は実行されない
end
