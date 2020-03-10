class ChangingRateDollarType < ActiveRecord::Migration[5.2]
  def change
  	remove_column :ratedollars, :rate
    add_column :ratedollars, :rate, :decimal
  end
end
