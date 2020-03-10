class CreateSubcategoryLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :subcategory_logs do |t|
      t.integer :subcategory_id
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
