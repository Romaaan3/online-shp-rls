class CreateMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :movements do |t|
      t.references :from_store, index: true
      t.references :to_store, index: true
      t.text :description

      t.timestamps
    end
  end
end
