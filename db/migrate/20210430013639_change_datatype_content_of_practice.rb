class ChangeDatatypeContentOfPractice < ActiveRecord::Migration[6.0]
  def change
    change_column :practices, :content, :text
  end
end
