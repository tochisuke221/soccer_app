class CreatePracticePtagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :practice_ptag_relations do |t|
      t.references :practice,         foreign_key: true
      t.references :ptag,             foreign_key: true
      t.timestamps
    end
  end
end
