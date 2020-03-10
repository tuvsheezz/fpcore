class ChangeCurrencyFieldOnItem < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :currency
    add_column :items, :currency, :integer
  end
end
