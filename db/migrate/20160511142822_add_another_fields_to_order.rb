class AddAnotherFieldsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :familija, :string
    add_column :orders, :otchestvo, :string
    add_column :orders, :email, :string
    add_column :orders, :gorod, :string
    add_column :orders, :ulica, :string
    add_column :orders, :dom, :integer
    add_column :orders, :korpus, :integer
    add_column :orders, :kv, :integer
    add_column :orders, :postal_index, :string
    add_column :orders, :tip_dostavki, :string
    add_column :orders, :tip_oplaty, :string
    remove_column :orders, :address, :string
  end
end
