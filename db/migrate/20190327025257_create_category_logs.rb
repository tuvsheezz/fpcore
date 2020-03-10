class CreateCategoryLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :category_logs do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
