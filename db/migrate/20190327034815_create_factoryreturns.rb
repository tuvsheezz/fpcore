class CreateFactoryreturns < ActiveRecord::Migration[5.2]
  def change
    create_table :factoryreturns do |t|
      t.references :item, foreign_key: true
      t.boolean :sent, default: false
      t.datetime :datesent
      t.boolean :reced, default: false
      t.datetime :detarec
      t.boolean :gave, default: false
      t.date :dategave
      t.text :note
      t.integer :user_id
      t.boolean :from, default: false

      t.timestamps
    end
  end
end
