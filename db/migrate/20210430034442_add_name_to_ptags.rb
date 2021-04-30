class AddNameToPtags < ActiveRecord::Migration[6.0]
  def change
    add_column :ptags, :name, :string,null: false,unique: true
  end
end
