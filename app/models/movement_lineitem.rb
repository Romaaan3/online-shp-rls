# == Schema Information
#
# Table name: movement_lineitems
#
#  id          :integer          not null, primary key
#  part_id     :integer
#  movement_id :integer
#  q           :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class MovementLineitem < ApplicationRecord
  belongs_to :part
  belongs_to :movement
  
	default_scope { order('id') } 

	validates_uniqueness_of :part_id, :scope => [:movement_id]
end
