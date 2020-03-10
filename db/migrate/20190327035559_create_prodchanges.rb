class CreateProdchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :prodchanges do |t|
      t.references :branch, foreign_key: true
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :change

      t.timestamps
    end
  end
end
