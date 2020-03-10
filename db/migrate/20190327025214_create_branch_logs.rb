class CreateBranchLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :branch_logs do |t|
      t.string :branch_id
      t.string :user_id
      t.string :name
      t.string :address
      t.string :note

      t.timestamps
    end
  end
end
