class CreateRatedollars < ActiveRecord::Migration[5.2]
  def change
    create_table :ratedollars do |t|
      t.string :rate, null: false

      t.timestamps
    end
  end
end
