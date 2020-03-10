class CreateDollarLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dollar_logs do |t|
      t.integer :dollar_id
      t.integer :user_id
      t.string :note
      t.decimal :rate

      t.timestamps
    end
  end
end
