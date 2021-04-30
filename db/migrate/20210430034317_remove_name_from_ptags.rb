class RemoveNameFromPtags < ActiveRecord::Migration[6.0]
  def change
    remove_column :ptags, :name, :string
  end
end
