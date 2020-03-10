class AddingMnNameToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :name_mn, :string, default: "", null: false
  	add_column :item_logs, :name_mn, :string
  end
end
