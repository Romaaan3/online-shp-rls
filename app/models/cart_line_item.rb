# == Schema Information
#
# Table name: cart_line_items
#
#  id         :integer          not null, primary key
#  part_id    :integer
#  cart_id    :integer
#  q          :integer          default("1")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price      :decimal(, )
#

class CartLineItem < ApplicationRecord
  belongs_to :part
  belongs_to :cart

  def total_price
    self.price * q
  end

  def decrement
    if self.q > 1
      self.q -= 1
    else
      self.destroy
    end
    self
  end

  def increment
    self.q += 1
    self
  end

end
