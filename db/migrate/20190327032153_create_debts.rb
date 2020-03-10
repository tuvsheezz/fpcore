class CreateDebts < ActiveRecord::Migration[5.2]
  def change
    create_table :debts do |t|
      t.references :sale, foreign_key: true
      t.references :user, foreign_key: true
      t.references :branch, foreign_key: true
      t.decimal :remainder, null: false, default: 0
      t.decimal :paid, null: false, default: 0
      t.decimal :amount, null: false, default: 0
      t.text :note
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
