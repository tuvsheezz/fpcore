class ChangeCurrencyTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :currencies, :currency_name, :string
  end
end
