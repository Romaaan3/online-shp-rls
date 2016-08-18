class AddPartToPicture < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :part, foreign_key: true, index: true
  end
end
