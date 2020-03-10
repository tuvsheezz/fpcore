class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.references :subcategory, foreign_key: true
      t.integer :amount, null: false
      t.decimal :price, null: false
      t.decimal :maxp, null: false
      t.decimal :minp, null: false
      t.string :bar, null: false
      t.string :currency

      t.timestamps
    end
  end
end
