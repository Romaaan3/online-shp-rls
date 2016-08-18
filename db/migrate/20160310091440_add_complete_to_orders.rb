class AddCompleteToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :complete, :boolean
  end
end
