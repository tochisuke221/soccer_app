require 'rails_helper'

RSpec.describe 'Events', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '予定追加' do
    before do
      @event = FactoryBot.build(:event)
    end
    context '予定追加できるとき' do
      it 'ユーザは正しい情報を入力すれば、予定を追加できる' do
        sign_in(@user)
        expect(find('.dropdown').click).to have_content('予定表')
        visit user_events_path(@user)
        fill_in 'event_title', with: @event.title
        expect  do
          click_on '追加'
          sleep 1
        end.to change { Event.count }.by(1)
        expect(page).to have_content(@event.title)
      end
    end
    context '予定追加できないとき' do
      it 'ユーザは正しく情報を入力できない時、予定を追加できない' do
        sign_in(@user)
        visit user_events_path(@user)
        fill_in 'event_title', with: ''
        expect  do
          click_on '追加'
          sleep 1
        end.to change { Event.count }.by(0)
        expect(page).to have_content('予定内容を入力してください')
      end
    end
  end
  describe '予定削除' do
    context '予定削除できるとき' do
      it 'ユーザは予定追加済みの予定をクリックすると削除できる' do
        @event = FactoryBot.create(:event, user_id: @user.id)
        sign_in(@user)
        visit user_events_path(@user)
        expect(page).to have_content(@event.title)
        expect do
          click_on @event.title
          expect(page.accept_confirm).to eq '本当に予定を削除してもいいですか？'
          sleep 1
        end.to change { Event.count }.by(-1)
        expect(page).to have_no_content(@event.title)
      end
    end
  end
end
