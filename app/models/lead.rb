# == Schema Information
#
# Table name: leads
#
#  id         :integer          not null, primary key
#  name       :string
#  tel        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Lead < ApplicationRecord
  extend FriendlyId
  friendly_id :id

	default_scope { order("id DESC") }

  validates :name, presence: true
  validates :tel, presence: true
end
