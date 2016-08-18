# == Schema Information
#
# Table name: brands
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  description :string
#

class Brand < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

	has_many :parts
	validates :name, presence: true
	validates :name, uniqueness: true


  def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    brand = find_by_id(row["id"]) || new
    brand.attributes = row.to_hash
    brand.save!
  end
end

def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "utf-8"})
        when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
        else raise "Unknown file type: #{file.original_filename}"
    end
end

  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    columns = %w(id name)
    csv << columns
    all.each do |product|
      csv << product.attributes.values_at(*columns)
    end
  end
end

  def self.get_blank(options = {})
    CSV.generate(options) do |csv|
      columns = %w(id name)
      csv << columns
    end
  end
end
