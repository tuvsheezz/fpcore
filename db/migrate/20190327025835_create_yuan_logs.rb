class CreateYuanLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :yuan_logs do |t|
      t.integer :yuan_id
      t.integer :user_id
      t.string :note
      t.decimal :rate

      t.timestamps
    end
  end
end
