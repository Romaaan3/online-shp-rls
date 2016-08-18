class AddFieldsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :mobile, :string
    add_column :orders, :address, :string
    add_column :orders, :comment, :text
  end
end
