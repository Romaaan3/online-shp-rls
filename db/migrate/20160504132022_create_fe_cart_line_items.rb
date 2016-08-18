class CreateFeCartLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_line_items do |t|
      t.references :part, foreign_key: true
      t.belongs_to :cart, foreign_key: true
      t.integer :q, default: 1

      t.timestamps
    end
  end
end
