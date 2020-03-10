class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :bto, null: false
      t.integer :bfrom, null: false
      t.references :item, foreign_key: true
      t.decimal :amount, null: false
      t.integer :uto, null: false
      t.integer :ufrom, null: false
      t.boolean :check, default: false

      t.timestamps
    end
  end
end
