require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいねをする' do
    before do 
      @like=FactoryBot.build(:like)
    end
    context 'いいねが保存される時' do
      it '正しい情報が存在する時、言い値は保存される' do
        expect(@like).to be_valid
      end
    end
    context 'いいねが保存されない時' do
      it 'ユーザが紐づいていないと保存されない' do
        @like=FactoryBot.build(:like,user_id:nil)
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end  
      it '投稿が紐づいていないと保存されない' do
        @like=FactoryBot.build(:like,practice_id:nil)
        @like.valid?
        expect(@like.errors.full_messages).to include("Practiceを入力してください")
      end  
    end
  end
end
