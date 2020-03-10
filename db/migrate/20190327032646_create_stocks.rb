class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :seller_id
      t.integer :nyabo_id
      t.integer :branch_id

      t.timestamps
    end
  end
end
