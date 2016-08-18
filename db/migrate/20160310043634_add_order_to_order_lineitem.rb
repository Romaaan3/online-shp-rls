class AddOrderToOrderLineitem < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_lineitems, :order, foreign_key: true, index: true
  end
end
