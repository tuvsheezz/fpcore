class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :branch, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :noat, default: false
      t.decimal :tax, null:false, default: 0
      t.integer :salestatus_id
      t.decimal :remainder, null:false, default: 0
      t.decimal :total, null:false, default: 0
      t.text :note

      t.timestamps
    end
  end
end
