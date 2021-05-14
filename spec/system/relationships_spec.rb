require 'rails_helper'

RSpec.describe 'Relationships', js: true, type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
  end
  describe 'フォロー機能' do
    context 'フォローできるとき' do
      it '他ユーザの詳細ページでフォローボタンを押すとフォローできる' do
        sign_in(@user)
        visit user_path(@another)
        expect(page).to have_content('フォロー')
        expect do
          find('#f-btn').click
          sleep 1
        end.to change { Relationship.count }.by(1)
        expect(page).to have_content('フォロー解除')
      end
    end
    context 'フォローできないとき' do
      it '自分のことはフォローできない' do
        sign_in(@user)
        visit user_path(@user)
        expect(page).to have_no_selector('#f-btn')
      end
      it 'すでにフォローしているユーザにのことは新規にフォローできない' do
        @relationship = Relationship.create(user_id: @user.id, follow_id: @another.id)
        visit user_path(@another)
        expect(page).to have_no_content('フォロー')
      end
    end
  end
  describe 'フォロー解除機能' do
    context 'フォロー解除できるとき' do
      it '他ユーザの詳細ページでフォロー解除ボタンを押すとフォローできる' do
        @relationship = Relationship.create(user_id: @user.id, follow_id: @another.id)
        sign_in(@user)
        visit user_path(@another)
        expect(page).to have_content('フォロー解除')
        expect do
          find('#f-btn').click
          sleep 1
        end.to change { Relationship.count }.by(-1)
        expect(page).to have_content('フォロー')
      end
    end
    context 'フォロー解除できないとき' do
      it 'まだフォローしていないユーザにのことはフォロー解除できない' do
        sign_in(@user)
        visit user_path(@another)
        expect(page).to have_no_content('フォロー解除')
      end
    end
  end
end
