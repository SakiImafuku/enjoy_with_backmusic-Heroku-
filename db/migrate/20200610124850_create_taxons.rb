class CreateTaxons < ActiveRecord::Migration[5.2]
  def change
    create_table :taxons do |t|
      t.string :name
      t.integer :taxonomy_id

      t.timestamps
    end
    add_index :taxons, :name, unique: true
    add_index :taxons, :taxonomy_id
  end
end
