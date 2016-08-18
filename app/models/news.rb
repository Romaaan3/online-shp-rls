# == Schema Information
#
# Table name: news
#
#  id                 :integer          not null, primary key
#  name               :string
#  anons              :string
#  text               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  slug               :string
#

class News < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
	
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
