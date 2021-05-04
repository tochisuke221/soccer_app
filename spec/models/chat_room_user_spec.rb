require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  describe '中間テーブルの作成' do
    before do
      @chat_room_user = FactoryBot.build(:chat_room_user)
    end
    context '作成できる時' do
      it '正しく情報が存在する時登録できる' do
        expect(@chat_room_user).to be_valid
      end
    end
    context '作成できない時' do
      it 'cht_roomと紐づいていない時、登録できない' do
        @chat_room_user = FactoryBot.build(:chat_room_user, chat_room_id: nil)
        @chat_room_user.valid?
        expect(@chat_room_user.errors.full_messages).to include('Chat roomを入力してください')
      end
      it 'userと紐づいてない時、登録できない' do
        @chat_room_user = FactoryBot.build(:chat_room_user, user_id: nil)
        @chat_room_user.valid?
        expect(@chat_room_user.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
