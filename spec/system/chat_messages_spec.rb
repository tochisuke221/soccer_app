require 'rails_helper'

RSpec.describe 'ChatMessages', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
    @chat_room = FactoryBot.create(:chat_room)
    chat_room_user_first = FactoryBot.create(:chat_room_user, chat_room_id: @chat_room.id, user_id: @user.id)
    chat_room_user_second = FactoryBot.create(:chat_room_user, chat_room_id: @chat_room.id, user_id: @another.id)
  end
  describe 'チャットメッセージ送信機能' do
    before do
      @chat_message = FactoryBot.build(:chat_message)
    end
    context 'メッセージを送れる時' do
      it 'ユーザは他ユーザの詳細ページのDMボタンを押して、チャットルームからメッセージを送れる' do
        sign_in(@user)
        visit user_path(@another)
        expect(page).to have_content('DMする')
        click_on 'DMする'
        expect(current_path).to eq(user_chat_room_path(@another, @chat_room))
        fill_in 'chat_message_content', with: @chat_message.content
        expect  do
          find('input[name="commit"]').click
          sleep 1
        end.to change { ChatMessage.count }.by(1)
        expect(page).to have_content(@chat_message.content)
      end
      it 'ユーザはすでにあるチャットルームから、指定の相手にメッセージを送ることができる' do
        sign_in(@user)
        visit user_chat_rooms_path(@user)
        expect(page).to have_content(@another.name)
        click_on @another.name
        expect(current_path).to eq(user_chat_room_path(@another, @chat_room))
        fill_in 'chat_message_content', with: @chat_message.content
        expect  do
          find('input[name="commit"]').click
          sleep 1
        end.to change { ChatMessage.count }.by(1)
        expect(page).to have_content(@chat_message.content)
      end
    end
    context 'メッセージを送れない時' do
      it 'ユーザは自分自身にDMは送ることができない' do
        sign_in(@user)
        visit user_path(@user)
        expect(page).to have_no_content('DMする')
      end
      it 'ユーザは空白のDMは送ることができない' do
        sign_in(@user)
        visit user_path(@another)
        expect(page).to have_content('DMする')
        click_on 'DMする'
        expect(current_path).to eq(user_chat_room_path(@another, @chat_room))
        fill_in 'chat_message_content', with: ''
        expect  do
          find('input[name="commit"]').click
          sleep 1
        end.to change { ChatMessage.count }.by(0)
      end
    end
  end
  describe 'チャットメッセージ受信機能' do
    before do
      @chat_message = FactoryBot.create(:chat_message, user_id: @another.id, chat_room_id: @chat_room.id)
    end
    context 'メッセージの受信ができる時' do
      it 'ユーザは他ユーザが送ったメッセージに対して、メッセージ一覧から受信・確認することができる' do
        sign_in(@user)
        visit user_chat_rooms_path(@user)
        expect(page).to have_content(@another.name)
        expect(page).to have_content('1')
        click_on @another.name
        expect(current_path).to eq(user_chat_room_path(@another, @chat_room))
        expect(page).to have_content(@chat_message.content)
      end
    end
    context 'メッセージを受信できない時' do
      it 'ユーザは他ユーザ間でやりとりしているメッセージは受信できない' do
        @another_chat_room = ChatRoom.create
        @another_chat_message = FactoryBot.create(:chat_message, user_id: @another.id, chat_room_id: @another_chat_room.id)
        sign_in(@user)
        visit user_chat_rooms_path(@user)
        expect(page).to have_content(@another.name)
        click_on @another.name
        expect(current_path).to eq(user_chat_room_path(@another, @chat_room))
        expect(page).to have_no_content(@another_chat_message.content)
      end
    end
  end

  describe 'チャットメッセージ既読機能' do
    context 'メッセージの既読通知を受け取ることがができる時' do
      it 'ユーザが送ったメッセージを他ユーザが見た時、既読通知を受け取れる' do
        @chat_message = FactoryBot.create(:chat_message, user_id: @user.id, chat_room_id: @chat_room.id, check: true)
        sign_in(@user)
        visit user_chat_room_path(@another, @chat_room)
        expect(page).to have_content('既読')
      end
    end
    context 'メッセージの既読通知を受け取ることができない時' do
      it 'ユーザが送ったメッセージを他ユーザがまだ見てない時、既読通知を受け取れない' do
        @chat_message = FactoryBot.create(:chat_message, user_id: @user.id, chat_room_id: @chat_room.id, check: false)
        sign_in(@user)
        visit user_chat_room_path(@another, @chat_room)
        expect(page).to have_no_content('既読')
      end
    end
  end
end
