require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'メッセージを送信する時' do
    before do
      @chat_message = FactoryBot.build(:chat_message)
    end
    context '保存できる時' do
      it '全ての項目が入力されていれば保存できる' do
        expect(@chat_message).to be_valid
      end
    end
    context '保存できない時' do
      it 'メッセージ内容が空であると保存できない' do
        @chat_message.content = ''
        @chat_message.valid?
        expect(@chat_message.errors.full_messages).to include('Contentを入力してください')
      end
      it 'ユーザと紐づいていないと保存できない' do
        @chat_message = FactoryBot.build(:chat_message, user_id: nil)
        @chat_message.valid?
        expect(@chat_message.errors.full_messages).to include('Userを入力してください')
      end
      it 'ルームと紐づいてないと保存できない' do
        @chat_message = FactoryBot.build(:chat_message, chat_room_id: nil)
        @chat_message.valid?
        expect(@chat_message.errors.full_messages).to include('Chat roomを入力してください')
      end
    end
  end
end
