class AddDescriptionToBrandsAndCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :description, :string
    add_column :categories, :description, :string
  end
end
