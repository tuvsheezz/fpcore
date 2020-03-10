class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :en, null: false
      t.string :mn, null: false

      t.timestamps
    end
  end
end
