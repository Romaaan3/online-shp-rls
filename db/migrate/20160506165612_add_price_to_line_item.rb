class AddPriceToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_line_items, :price, :decimal
    CartLineItem.all.each do |li|
      li.price = li.part.cost_1
    end
  end
end
