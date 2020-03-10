class CreateRateyuans < ActiveRecord::Migration[5.2]
  def change
    create_table :rateyuans do |t|
      t.decimal :rate, null: false

      t.timestamps
    end
  end
end
