class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.integer :practice_id
      t.integer :pcomment
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
