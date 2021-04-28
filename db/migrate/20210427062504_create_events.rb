class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :user,           null:false,foreign_key:true
      t.string :title,              null:false
      t.datetime :start_time,       null:false
      t.timestamps
    end
  end
end
