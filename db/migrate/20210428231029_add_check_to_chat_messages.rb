class AddCheckToChatMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :check, :boolean,null:false,default:false
  end
end
