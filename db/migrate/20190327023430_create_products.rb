class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :item, foreign_key: true
      t.references :branch, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
