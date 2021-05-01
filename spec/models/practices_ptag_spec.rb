require 'rails_helper'

RSpec.describe PracticesPtag, type: :model do
  describe '練習内容新規投稿' do
    before do
      user=FactoryBot.create(:user)
      @practices_ptag=FactoryBot.build(:practices_ptag,user_id:user.id)
    end
    context '新規投稿できるとき' do
      it '正しく項目が入力されていれば保存できる' do
        expect(@practices_ptag).to be_valid
      end
      it 'タイトル名が25文字以下であれば保存できる' do
        @practices_ptag.title="この練習は最高になるための練習だぜ！25文字！！!"
        expect(@practices_ptag).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'タイトル名が空であると保存できない' do
        @practices_ptag.title=""
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("タイトルを入力してください");
      end
      it 'タイトル名が26文字以上の時保存できない' do
        @practices_ptag.title="このタイトルは26文字ちょうどです！！!！！！！！！"
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("タイトルは25文字以内で入力してください");
      end
      it '練習詳細が空であると保存できない' do
        @practices_ptag.content=""
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("練習の内容を入力してください");
      end
      it 'カテゴリーが選択されていないと保存できない' do
        @practices_ptag.category_id="1"
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("練習カテゴリーを入力してください");
      end
      it '負荷のレベルが選択されていないと保存できない' do
        @practices_ptag.hardlevel_id="1"
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("負荷のレベルを入力してください");
      end
      it 'タグが空であると保存できない' do
        @practices_ptag.name=""
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("タグを入力してください");
      end
      it 'ユーザが紐づいていないと保存できない' do
        @practices_ptag.user_id=nil
        @practices_ptag.valid?
        expect(@practices_ptag.errors.full_messages).to include("Userを入力してください");
      end
    end
  end
end
