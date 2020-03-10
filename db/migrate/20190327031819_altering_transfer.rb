class AlteringTransfer < ActiveRecord::Migration[5.2]
  def change
  	remove_column :transfers, :amount
  	remove_column :transfers, :item_id
  	add_column :transfers, :checker, :boolean, default: 1
  end
end
