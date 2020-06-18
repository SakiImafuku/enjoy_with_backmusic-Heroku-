class CreateTaxonomies < ActiveRecord::Migration[5.2]
  def change
    create_table :taxonomies do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end
    add_index :taxonomies, :name, unique: true
    add_index :taxonomies, :position, unique: true
  end
end
