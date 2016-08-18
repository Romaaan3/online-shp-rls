# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Store < ApplicationRecord
  has_many :existences, :dependent => :destroy
  has_many :parts, through: :existences

  has_many :orders, foreign_key: :from_store_id, :dependent => :destroy

  after_create :add_store_to_all_parts

  accepts_nested_attributes_for :existences

	validates :name, presence: true
	validates :name, uniqueness: true

	default_scope { order('id') }

  def has_parts
    sum = 0
    self.existences.each do |existence|
      sum += existence.q
    end
    sum != 0
  end

	private
		def add_store_to_all_parts
  		@parts = Part.all
      @parts.each do |part|
        part.existences.build(store_id: self.id).save
      end
		end
end
