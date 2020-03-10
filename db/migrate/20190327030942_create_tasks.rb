class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :sale, foreign_key: true
      t.references :item, foreign_key: true
      t.decimal :amount, null:false, default: 0
      t.decimal :total, null:false, default: 0
      t.decimal :price, null:false, default: 0

      t.timestamps
    end
  end
end
