class AddingStatusToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status_id, :integer, default: 1
  end
end
