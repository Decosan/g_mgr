class AddDateAndCourseIdToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :play_day, :date
    add_reference :scores, :course, foreign_key: true
  end
end
