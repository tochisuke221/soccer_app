class CreatePractices < ActiveRecord::Migration[6.0]
  def change
    create_table :practices do |t|
      t.references :user,            null:false,foreign_key:true
      t.string :title,                  null:false
      t.string :content,                null:false
      t.integer :category_id,           null:false
      t.integer :hardlevel_id,          null:false
      t.timestamps
    end
  end
end
