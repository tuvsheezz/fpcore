class AddingStatusIntoItemLog < ActiveRecord::Migration[5.2]
  def change
    add_column :item_logs, :status, :integer
  end
end
