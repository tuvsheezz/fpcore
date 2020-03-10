class AddSpecsIntoProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :spec, :text, null: false, default: ""
  end
end
