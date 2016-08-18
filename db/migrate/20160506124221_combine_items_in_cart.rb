class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def up
    Cart.all.each do |cart|
      sums = cart.cart_line_items.group(:part_id).sum(:q)

      sums.each do |part_id, q|
        if q > 1
          cart.cart_line_items.where(part_id: part_id).delete_all

          item = cart.cart_line_items.build(part_id: part_id)
          item.q = q
          item.save!
        end
      end
    end
  end


  def down
    CartLineItem.where("q>1").each do |cart_line_item|
    cart_line_item.q.times do
      LineItem.create cart_id: cart_line_item.cart_id,
      part_id: cart_line_item.part_id, q: 1
    end

    cart_line_item.destroy
    end
  end
end
