class AddTdkToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :title, :string
    add_column :blocks, :description, :string
    add_column :blocks, :keywords, :string
  end
end
