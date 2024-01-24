class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.string :genre
      t.integer :evaluation
      t.boolean :is_delete
      t.references :user, foreign_key: true
    end
  end
end
