class CreateSalestatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :salestatuses do |t|
      t.string :en
      t.string :mn

      t.timestamps
    end
  end
end
