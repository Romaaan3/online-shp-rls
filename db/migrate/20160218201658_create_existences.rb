class CreateExistences < ActiveRecord::Migration[5.0]
  def change
    create_table :existences do |t|
      t.references :part, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :q, default: 0

      t.timestamps
    end
  end
end
