# == Schema Information
#
# Table name: movements
#
#  id            :integer          not null, primary key
#  from_store_id :integer
#  to_store_id   :integer
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  complete      :boolean          default("false")
#  slug          :string
#

class Movement < ApplicationRecord
  extend FriendlyId
  friendly_id :id, use: :slugged

  belongs_to :from_store, class_name: "Store", required: false
  belongs_to :to_store, class_name: "Store", required: false
  has_many :lineitems, class_name: "MovementLineitem", dependent: :destroy

	default_scope { order('id DESC') }
  
end
