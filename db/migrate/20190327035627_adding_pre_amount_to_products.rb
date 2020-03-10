class AddingPreAmountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :pre_amount, :integer, default: 0
  end
end
