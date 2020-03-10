class ItemsBarCodeToNull < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :bar
    add_column :items, :bar, :string
  end
end
