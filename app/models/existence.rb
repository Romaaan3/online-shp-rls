# == Schema Information
#
# Table name: existences
#
#  id         :integer          not null, primary key
#  part_id    :integer
#  store_id   :integer
#  q          :integer          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Existence < ApplicationRecord
  belongs_to :part
  belongs_to :store
  # accepts_nested_attributes_for :part
  # accepts_nested_attributes_for :store

  # scope :not_null, -> { where("q > ?", 0) } 
end
