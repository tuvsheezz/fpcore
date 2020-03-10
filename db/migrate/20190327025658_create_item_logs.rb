class CreateItemLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :item_logs do |t|
      t.integer :item_id
      t.string :name
      t.integer :user_id
      t.string :bar
      t.integer :subcategory_id
      t.decimal :price
      t.decimal :maxp
      t.decimal :minp
      t.integer :minimum
      t.integer :currency_id
      t.string :note

      t.timestamps
    end
  end
end
