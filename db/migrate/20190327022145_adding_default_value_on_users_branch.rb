class AddingDefaultValueOnUsersBranch < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :branch_id
  	add_column :users, :branch_id, :integer, default: 0
  	remove_column :users, :role
  	add_column :users, :role, :string, default: "member"
  end
end
