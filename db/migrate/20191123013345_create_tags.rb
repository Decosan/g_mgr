class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :body
      t.integer :score_id

      t.timestamps
    end
  end
end
