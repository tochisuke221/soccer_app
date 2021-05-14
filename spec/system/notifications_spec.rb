require 'rails_helper'

RSpec.describe 'Notifications', js: true, type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:user)
    @third_user = FactoryBot.create(:user)
    @my_practice = FactoryBot.create(:practice, user_id: @user.id)
    @second_practice = FactoryBot.create(:practice, user_id: @second_user.id)
    @third_practice = FactoryBot.create(:practice, user_id: @third_user.id)
  end
  describe 'コメントに関しての通知' do
    context 'コメント通知が来る時' do
      it '他ユーザが自分の投稿にコメントした時、ユーザは通知を受け取ることができる' do
        sign_in(@second_user)
        visit practice_path(@my_practice)
        fill_in 'pcomment_comment', with: 'Good'
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_selector('.notice')
        visit notifications_path
        expect(page).to have_content("#{@second_user.name}があなたの投稿にコメントしました")
      end
    end
    context 'コメント通知がこないとき' do
      it 'ユーザは自分自身の投稿に自分がコメントしても通知を受け取ることはできない' do
        sign_in(@user)
        visit practice_path(@my_practice)
        fill_in 'pcomment_comment', with: 'Good'
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Notification.count }.by(1)
        expect(page).to have_no_selector('.notice')
        visit notifications_path
        expect(page).to have_no_content("#{@user.name}があなたの投稿にコメントしました")
      end
      it 'ユーザはユーザ2がユーザ3にコメントしても通知を受け取ることはできない' do
        sign_in(@second_user)
        visit practice_path(@third_practice)
        fill_in 'pcomment_comment', with: 'Good'
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_no_selector('.notice')
      end
    end
  end
  describe 'いいねに関しての通知' do
    context 'いいね通知が来る時' do
      it '他ユーザが自分の投稿にいいねした時、ユーザは通知を受け取ることができる' do
        sign_in(@second_user)
        expect do
          find("#like-#{@my_practice.id}").find('.practice_like').click
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_selector('.notice')
        visit notifications_path
        expect(page).to have_content("#{@second_user.name}があなたの投稿にいいねしました")
      end
    end
    context 'いいね通知がこないとき' do
      it 'ユーザは自分自身の投稿に自分がいいねしても通知を受け取ることはできない' do
        sign_in(@user)
        expect do
          find("#like-#{@my_practice.id}").find('.practice_like').click
          sleep 1
        end.to change { Notification.count }.by(1)
        expect(page).to have_no_selector('.notice')
      end
      it 'ユーザはユーザ2がユーザ3の投稿をいいねしても通知を受け取ることはできない' do
        sign_in(@second_user)
        expect do
          find("#like-#{@third_practice.id}").find('.practice_like').click
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_no_selector('.notice')
      end
    end
  end
  describe 'フォローに関しての通知' do
    context 'フォロー通知が来る時' do
      it '他ユーザが自分をフォローした時、ユーザは通知を受け取ることができる' do
        sign_in(@second_user)
        visit user_path(@user)
        expect do
          find('#f-btn').click
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_selector('.notice')
        visit notifications_path
        expect(page).to have_content("#{@second_user.name}があなたをフォローしました")
      end
    end
    context 'フォロー通知がこないとき' do
      it '他ユーザが他ユーザをフォローしても第三者は通知を受け取らない' do
        sign_in(@second_user)
        visit user_path(@third_user)
        expect do
          find('#f-btn').click
          sleep 1
        end.to change { Notification.count }.by(1)
        sign_out(@second_user)
        sign_in(@user)
        expect(page).to have_no_selector('.notice')
      end
    end
  end
end
