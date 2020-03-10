class AddingMinimumAmountToItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :minimum, :integer, default: 0
  end
end
