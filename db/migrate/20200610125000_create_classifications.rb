class CreateClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.integer :musicpost_id
      t.integer :taxon_id

      t.timestamps
    end
    add_index :classifications, :musicpost_id
    add_index :classifications, :taxon_id
    add_index :classifications, [:musicpost_id, :taxon_id], unique: true
  end
end
