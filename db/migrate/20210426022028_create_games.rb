class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :user,             null:false,foreign_key:true
      t.datetime :gameday,            null:false
      t.string :location,             null:false
      t.integer :gametime_id,         null:false
      t.integer :gamenum_id,          null:false
      t.integer :level_id,            null:false
      t.string  :title,               null:false
      t.text :description         
      t.boolean :check,               default: false, null: false
      t.timestamps
    end
  end
end
