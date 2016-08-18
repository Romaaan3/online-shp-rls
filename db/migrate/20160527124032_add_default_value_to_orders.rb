class AddDefaultValueToOrders < ActiveRecord::Migration[5.0]
  def change
  	change_column :orders, :complete, :boolean, default: false
  end
end
