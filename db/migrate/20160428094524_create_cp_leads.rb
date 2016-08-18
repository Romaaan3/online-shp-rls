class CreateCpLeads < ActiveRecord::Migration[5.0]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :tel

      t.timestamps
    end
  end
end
