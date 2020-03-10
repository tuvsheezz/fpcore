class CreateTaks < ActiveRecord::Migration[5.2]
  def change
    create_table :taks do |t|
      t.references :item, foreign_key: true
      t.references :sale, foreign_key: true
      t.decimal :amount, null:false, default: 0
      t.decimal :price, null:false, default: 0
      t.decimal :subs, null:false, default: 0
      t.decimal :percent, null:false, default: 0
      t.decimal :total, null:false, default: 0
      t.references :user, foreign_key: true
      t.boolean :checker, null:false, default: true

      t.timestamps
    end
  end
end
