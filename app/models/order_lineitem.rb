# == Schema Information
#
# Table name: order_lineitems
#
#  id          :integer          not null, primary key
#  p_name      :string
#  p_cost      :float
#  q           :integer
#  part_id     :integer
#  p_full_cost :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :integer
#

class OrderLineitem < ApplicationRecord
  belongs_to :order
  belongs_to :part

	validates_uniqueness_of :part_id, :scope => [:order_id]
end
