class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :in_score
      t.integer :out_score
      t.integer :total_score
      t.integer :in_put
      t.integer :out_put
      t.integer :total_put
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
