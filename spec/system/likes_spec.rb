require 'rails_helper'

RSpec.describe 'Likes', js: true, type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
    @practice = FactoryBot.create(:practice)
  end
  describe 'いいね機能' do
    context 'いいねできるとき' do
      it 'ユーザは他ユーザの投稿にトップページからいいねできる' do
        sign_in_on_browser(@user)
        expect do
          find('.practice_like').click
          sleep 1
        end.to change { Like.count }.by(1)
      end
    end
    context 'いいねできないとき' do
      it 'ユーザはすでにいいねした投稿にはいいねできない' do
        @like = FactoryBot.create(:like, user_id: @user.id, practice_id: @practice.id)
        sign_in_on_browser(@user)
        expect do
          find('.practice_like').click
          sleep 1
        end.to change { Like.count }.by(-1)
      end
      it '未ログインユーザは他ユーザの投稿にトップページからいいねできない' do
        visit root_path
        expect do
          find('.practice_like').click
          sleep 1
        end.to change { Like.count }.by(0)
      end
    end
  end
  describe 'いいね解除機能' do
    context 'いいね解除できるとき' do
      it 'ユーザはいい済みの他ユーザの投稿にトップページからいいね解除できる' do
        @like = FactoryBot.create(:like, user_id: @user.id, practice_id: @practice.id)
        sign_in_on_browser(@user)
        expect do
          find('.practice_like').click
          sleep 1
        end.to change { Like.count }.by(-1)
      end
    end
    context 'いいね解除できないとき' do
      it 'ユーザはすでにいいね解除した投稿にはいいね解除できない' do
        sign_in_on_browser(@user)
        expect do
          find('.practice_like').click
          sleep 1
        end.to change { Like.count }.by(1)
      end
    end
  end
end
