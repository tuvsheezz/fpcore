class UserRoleTypeToInteger < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :role
  	add_column :users, :role_id, :integer
  	remove_column :users, :branch_id
  	add_column :users, :branch_id, :integer
  end
end
