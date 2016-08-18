class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :seller, index: true
      t.references :client, index: true
      t.boolean :payd
      t.references :from_store, index: true

      t.timestamps
    end
    add_foreign_key :orders, :users, column: :seller_id
    add_foreign_key :orders, :users, column: :client_id
    add_foreign_key :orders, :stores, column: :from_store_id
  end
end
