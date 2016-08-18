class CreateCpNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :name
      t.string :anons
      t.text :text

      t.timestamps
    end
  end
end
