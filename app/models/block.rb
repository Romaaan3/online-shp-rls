# == Schema Information
#
# Table name: blocks
#
#  id          :integer          not null, primary key
#  name        :string
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  title       :string
#  description :string
#  keywords    :string
#

class Block < ApplicationRecord
  extend FriendlyId
  friendly_id :id, use: :slugged
end
