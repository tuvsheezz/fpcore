class CreateTrans < ActiveRecord::Migration[5.2]
  def change
    create_table :trans do |t|
      t.references :transfer, foreign_key: true
      t.references :item, foreign_key: true
      t.decimal :amount, null: false, default: 0
      t.timestamps
    end
  end
end
