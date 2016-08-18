class AddSlugToEmailsAndLeads < ActiveRecord::Migration[5.0]
  def change
    add_column :emails, :slug, :string
    add_column :leads, :slug, :string
    
    add_index :emails, :slug, unique: true
    add_index :leads, :slug, unique: true
  end
end
