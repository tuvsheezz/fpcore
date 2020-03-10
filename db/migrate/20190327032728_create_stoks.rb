class CreateStoks < ActiveRecord::Migration[5.2]
  def change
    create_table :stoks do |t|
      t.references :stock, foreign_key: true
      t.references :item, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
