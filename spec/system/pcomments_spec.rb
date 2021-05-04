require 'rails_helper'

RSpec.describe 'Pcomments', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
    @my_practice = FactoryBot.create(:practice, user_id: @user.id)
    @another_practice = FactoryBot.create(:practice, user_id: @another.id)
  end
  describe 'コメント投稿機能' do
    context 'コメントできるとき' do
      before do
        @pcomment = FactoryBot.build(:pcomment)
      end
      it 'ユーザは他ユーザの投稿にコメントできる' do
        sign_in(@user)
        visit practice_path(@another_practice)
        fill_in 'pcomment_comment', with: @pcomment.comment
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Pcomment.count }.by(1)
        expect(page).to have_content(@pcomment.comment)
      end
      it 'ユーザは自分の投稿に対してもコメントできる' do
        sign_in(@user)
        visit practice_path(@my_practice)
        fill_in 'pcomment_comment', with: @pcomment.comment
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Pcomment.count }.by(1)
        expect(page).to have_content(@pcomment.comment)
      end
    end
    context 'コメントできないとき' do
      it 'ユーザは文字を入力しないでコメントしてもコメントできない' do
        sign_in(@user)
        visit practice_path(@another_practice)
        fill_in 'pcomment_comment', with: ''
        expect  do
          click_on 'コメントする'
          sleep 1
        end.to change { Pcomment.count }.by(0)
      end
    end
  end
  describe 'コメント削除機能' do
    before do
      @my_pcomment = FactoryBot.create(:pcomment, user_id: @user.id, practice_id: @another_practice.id)
      @another_pcomment = FactoryBot.create(:pcomment, user_id: @another.id, practice_id: @my_practice.id)
    end
    context 'コメント削除できるとき' do
      it 'ユーザは自身のコメントであれば削除できる' do
        sign_in(@user)
        visit practice_path(@another_practice)
        expect(page).to have_content(@my_pcomment.comment)
        expect do
          find('.fa-trash').click
          sleep 1
        end.to change { Pcomment.count }.by(-1)
      end
    end
    context 'コメント削除できないとき' do
      it 'ユーザは他人のコメントを削除することはできない(ゴミ箱マークがない)' do
        sign_in(@user)
        visit practice_path(@my_practice)
        expect(page).to have_content(@another_pcomment.comment)
        expect(page).to have_no_selector('.fa-trash')
      end
    end
  end
end
