class AddingSpecialPriceToItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :specialp, :decimal, default: 0
  	add_column :items, :special_flag, :boolean, default: false
  end
end
