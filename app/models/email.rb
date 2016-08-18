# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Email < ApplicationRecord
  extend FriendlyId
  friendly_id :id, use: :slugged
  
  validates :email, presence: true
	validates :email, uniqueness: true
end
