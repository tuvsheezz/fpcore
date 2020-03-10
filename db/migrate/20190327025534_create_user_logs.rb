class CreateUserLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_logs do |t|
      t.integer :u_id
      t.integer :user_id
      t.string :name
      t.integer :branch_id
      t.integer :role_id
      t.string :email
      t.string :phone1
      t.string :phone2
      t.string :address
      t.string :note
      t.string :password

      t.timestamps
    end
  end
end
