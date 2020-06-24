class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :musicpost, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :comments, [:user_id, :musicpost_id]
  end
end
