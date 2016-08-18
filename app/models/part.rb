# == Schema Information
#
# Table name: parts
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  cost_1      :float
#  cost_2      :float
#  brand_id    :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class Part < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :sort_by_id, -> { order("id ASC") }

  belongs_to :brand
  belongs_to :category
  before_destroy :ensure_not_referenced_by_any_line_item
  after_create :enable_all_stores

  has_many :existences, :dependent => :destroy
  has_many :stores, through: :existences
  has_many :cart_line_items
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :existences, :allow_destroy => true

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :cost_1, :numericality => { :greater_than_or_equal_to => 0 }
  validates :cost_2, :numericality => { :greater_than_or_equal_to => 0 }

  def simular(count)
    Part.where(category: self.category).order("RANDOM()").limit(count)
  end

  private

    def ensure_not_referenced_by_any_line_item
      if cart_line_items.empty?
        return true
      else
        return false
      end
    end

  	def enable_all_stores
  		@stores = Store.all
      @stores.each do |store|
        store.existences.build(part_id: self.id).save
      end
  	end

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
    columns = %w(id name cost_1 cost_2 brand_id category_id)
    csv << columns
    all.each do |product|
      csv << product.attributes.values_at(*columns)
    end
  end
end

  def self.get_blank(options = {})
    CSV.generate(options) do |csv|
      columns = %w(id name cost_1 cost_2 brand_id category_id)
      csv << columns
    end
  end
end
