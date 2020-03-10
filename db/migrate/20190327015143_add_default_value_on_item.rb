class AddDefaultValueOnItem < ActiveRecord::Migration[5.2]
  def change
  	change_column :items, :amount, :integer, default: 0
  end
end
