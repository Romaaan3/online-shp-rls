class Image < ActiveRecord::Migration[5.0]
  def change
	  create_table :images do |t|
      t.string     :alt,  default: ""
      t.string     :hint, default: ""
      t.attachment :file
      t.timestamps
    end
  end
end
