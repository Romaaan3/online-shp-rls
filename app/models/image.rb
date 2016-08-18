# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  alt               :string           default("")
#  hint              :string           default("")
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Image < ApplicationRecord
	has_attached_file :file, styles: { original: "1024x768>" }

  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
