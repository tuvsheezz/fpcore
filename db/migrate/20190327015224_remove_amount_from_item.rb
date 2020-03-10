class RemoveAmountFromItem < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :amount
  end
end
