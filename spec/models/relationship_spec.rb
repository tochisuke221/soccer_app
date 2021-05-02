require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '中間テーブル' do
    before do
      user=FactoryBot.create(:user)
      follow=FactoryBot.create(:user)
      @relationship=Relationship.new(user_id:user.id,follow_id:follow.id)
    end  
    context '中間テーブルに保存できる' do
      it '正しい情報が存在する時、保存できる' do
        expect(@relationship).to be_valid
      end
    end
    context '中間テーブルに保存できない' do
      it 'user_idが存在しないと保存できない' do
        @relationship.user_id=nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Userを入力してください")
      end
      it 'follow_idが存在しないと保存できない' do
        @relationship.follow_id=nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followを入力してください")
      end
    end
  end

end
