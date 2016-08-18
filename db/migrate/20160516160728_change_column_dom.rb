class ChangeColumnDom < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :dom, :string
  end
end
