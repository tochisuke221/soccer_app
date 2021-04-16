class CreatePcomments < ActiveRecord::Migration[6.0]
  def change
    create_table :pcomments do |t|
      t.references :practice,             null:false,foreign_key:true
      t.references :user,                 null:false,foreign_key:true
      t.text :comment,                    null:false
      t.timestamps
    end
  end
end
