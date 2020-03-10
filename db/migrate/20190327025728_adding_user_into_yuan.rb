class AddingUserIntoYuan < ActiveRecord::Migration[5.2]
  def change
  	add_column :rateyuans, :user_id, :integer
  	add_column :ratedollars, :user_id, :integer
  end
end
