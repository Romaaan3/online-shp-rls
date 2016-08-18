class AddSlugToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :slug, :string
    add_column :movements, :slug, :string
    add_column :users, :slug, :string
    add_column :stores, :slug, :string
    add_column :blocks, :slug, :string
    
    add_index :orders, :slug, unique: true
    add_index :movements, :slug, unique: true
    add_index :users, :slug, unique: true
    add_index :stores, :slug, unique: true
    add_index :blocks, :slug, unique: true
  end
end
