# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
	has_many :cart_line_items, dependent: :destroy

  def add_part(part_id)
    current_item = cart_line_items.find_by(part_id: part_id)
    if current_item
      current_item.q += 1
    else
      current_item = cart_line_items.build(part_id: part_id)
      current_item.price = current_item.part.cost_1
    end
    current_item
  end

  def total_price
    cart_line_items.to_a.sum { |item| item.total_price}
  end

  def total_quantity
    sum = 0
    cart_line_items.each do |i|
      sum += i.q
    end
    sum
  end
end
