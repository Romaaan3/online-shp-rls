class AddCompleteToMovements < ActiveRecord::Migration[5.0]
  def change
    add_column :movements, :complete, :boolean, default: false
  end
end
