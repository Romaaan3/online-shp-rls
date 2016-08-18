class CreateCpOrderLineitems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lineitems do |t|
      t.string :p_name
      t.float :p_cost
      t.integer :q
      t.references :part, foreign_key: true, index: true
      t.float :p_full_cost

      t.timestamps
    end
  end
end
