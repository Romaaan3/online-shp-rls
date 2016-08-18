class AddSlugToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :slug, :string
    add_column :categories, :slug, :string
    add_column :parts, :slug, :string
    
    add_index :brands, :slug, unique: true
    add_index :categories, :slug, unique: true
    add_index :parts, :slug, unique: true
  end
end
