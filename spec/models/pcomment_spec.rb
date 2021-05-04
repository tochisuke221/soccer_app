require 'rails_helper'

RSpec.describe Pcomment, type: :model do
  describe 'コメント投稿' do
    before do
      @pcomment = FactoryBot.build(:pcomment)
    end
    context 'コメントできる時' do
      it '正しく情報が存在する時、コメントできる' do
        expect(@pcomment).to be_valid
      end
    end
    context 'コメントできない時' do
      it 'コメント内容が空のとき、コメントできない' do
        @pcomment.comment = ''
        @pcomment.valid?
        expect(@pcomment.errors.full_messages).to include('Commentを入力してください')
      end
      it 'ユーザと紐づいてないとき' do
        @pcomment = FactoryBot.build(:pcomment, user_id: nil)
        @pcomment.valid?
        expect(@pcomment.errors.full_messages).to include('Userを入力してください')
      end
      it '練習投稿と紐づいてないとき' do
        @pcomment = FactoryBot.build(:pcomment, practice_id: nil)
        @pcomment.valid?
        expect(@pcomment.errors.full_messages).to include('Practiceを入力してください')
      end
    end
  end
end
