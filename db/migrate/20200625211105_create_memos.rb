class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.references :user, foreign_key: true
      t.references :musicpost, foreign_key: true
      t.text :memo

      t.timestamps
    end
    add_index :memos, [:user_id, :musicpost_id]
  end
end
