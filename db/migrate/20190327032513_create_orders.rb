class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :bar, null: false
      t.boolean :check, null: false, default: 0
      t.string :price, null: false, default: 0
      t.datetime :recieved

      t.timestamps
    end
  end
end
