class AddFullCostToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :full_cost, :float, default: 0
  end
end
