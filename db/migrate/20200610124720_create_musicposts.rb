class CreateMusicposts < ActiveRecord::Migration[5.2]
  def change
    create_table :musicposts do |t|
      t.integer :user_id
      t.string :title
      t.text :overview

      t.timestamps
    end
    add_index :musicposts, :user_id
    add_index :musicposts, :title
  end
end
