require 'rails_helper'

RSpec.describe 'ChatRooms', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
  end
  describe 'チャットルーム作成' do
    context 'チャットルームの作成ができるとき' do
      it 'ユーザは他ユーザの詳細ページの「DMする」を押すと、新規にチャットルームが作成される' do
        sign_in_on_browser(@user)
        visit user_path(@another)
        expect do
          click_on 'DMする'
        end.to change { ChatRoom.count }.by(1).and change { ChatRoomUser.count }.by(2)
      end
    end
    context 'チャットルームの作成がされないとき' do
      before do
        @chat_room = FactoryBot.create(:chat_room)
        @chat_room_user_first = FactoryBot.create(:chat_room_user, chat_room_id: @chat_room.id, user_id: @user.id)
        @chat_room_user_second = FactoryBot.create(:chat_room_user, chat_room_id: @chat_room.id, user_id: @another.id)
      end
      it 'すでにチャットしたことのあるユーザの詳細ページの「DMする」をクリックしても、チャットルームは作成されない' do
        sign_in_on_browser(@user)
        visit user_path(@another)
        expect do
          click_on 'DMする'
        end.to change { ChatRoom.count }.by(0).and change { ChatRoomUser.count }.by(0)
      end
      it 'ユーザはチャットルーム一覧にある宛先をクリックしてもチャットルームは新規には作成されない' do
        sign_in_on_browser(@user)
        visit user_chat_rooms_path(@user)
        expect(page).to have_content(@another.name)
        expect do
          click_on @another.name
        end.to change { ChatRoom.count }.by(0).and change { ChatRoomUser.count }.by(0)
      end
    end
  end
end
