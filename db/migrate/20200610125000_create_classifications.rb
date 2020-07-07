class CreateClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.belongs_to :musicpost
      t.belongs_to :taxon

      t.timestamps
    end
    add_index :classifications, [:musicpost_id, :taxon_id], unique: true
  end
end
