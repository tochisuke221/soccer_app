class CreatePtags < ActiveRecord::Migration[6.0]
  def change
    create_table :ptags do |t|
      t.string :name, null:false, uniqueness: true
      t.timestamps
    end
  end
end
