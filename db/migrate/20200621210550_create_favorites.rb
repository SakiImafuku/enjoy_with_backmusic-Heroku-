class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :musicpost, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:user_id, :musicpost_id]
  end
end
