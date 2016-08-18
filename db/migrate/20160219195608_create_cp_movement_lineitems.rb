class CreateCpMovementLineitems < ActiveRecord::Migration[5.0]
  def change
    create_table :movement_lineitems do |t|
      t.references :part, foreign_key: true, index: true
      t.references :movement, foreign_key: true, index: true
      t.integer :q

      t.timestamps
    end
  end
end
