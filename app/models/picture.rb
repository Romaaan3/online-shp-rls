# == Schema Information
#
# Table name: pictures
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  part_id           :integer
#

class Picture < ApplicationRecord
	belongs_to :part

  has_attached_file :file, styles: { full: "1280x1024>", medium: "460x380#", preview:"260x300#", thumb: "90x80#", cart_thumb: "60x60#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
