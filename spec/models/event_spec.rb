require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '予定の新規作成' do
    before do
      @event = FactoryBot.build(:event)
    end
    context '予定の新規登録ができる時' do
      it '正しく情報が入力されている時、作成できる' do
        expect(@event).to be_valid
      end
    end
    context '予定の新規登録ができない時' do
      it '予定内容が空のとき、保存できない' do
        @event.title = ''
        @event.valid?
        expect(@event.errors.full_messages).to include('予定内容を入力してください')
      end
      it '日時がからのとき、保存できない' do
        @event.start_time = ''
        @event.valid?
        expect(@event.errors.full_messages).to include('日時を入力してください')
      end
      it 'ユーザが紐づいていないとき' do
        @event = FactoryBot.build(:event, user_id: nil)
        @event.valid?
        expect(@event.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
