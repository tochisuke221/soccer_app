class CreatePracticeTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :practice_tag_relations do |t|

      t.timestamps
    end
  end
end
