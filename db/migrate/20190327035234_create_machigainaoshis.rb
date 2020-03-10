class CreateMachigainaoshis < ActiveRecord::Migration[5.2]
  def change
    create_table :machigainaoshis do |t|
      t.references :item, foreign_key: true
      t.references :product, foreign_key: true
      t.references :branch, foreign_key: true
      t.integer :nybo_id
      t.integer :seller_id
      t.integer :admin_id
      t.decimal :amount
      t.boolean :pre_stat, null: false
      t.boolean :check, null: false
      t.text :note

      t.timestamps
    end
  end
end
