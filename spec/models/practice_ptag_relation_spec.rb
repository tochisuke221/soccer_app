require 'rails_helper'

RSpec.describe PracticePtagRelation, type: :model do
  describe '中間テーブルの作成' do
    context '中間テーブルが作成できる時' do
      it '正しく情報が存在する場合は、作成される' do
        @practice_ptag_relation = FactoryBot.build(:practice_ptag_relation)
        expect(@practice_ptag_relation).to be_valid
      end
    end
    context '中間テーブルが作成できない時' do
      it 'Practiceと紐づいていないとき' do
        @practice_ptag_relation = FactoryBot.build(:practice_ptag_relation, practice_id: nil)
        @practice_ptag_relation.valid?
        expect(@practice_ptag_relation.errors.full_messages).to include('Practiceを入力してください')
      end
      it 'Ptagと紐づいていないとき' do
        @practice_ptag_relation = FactoryBot.build(:practice_ptag_relation, ptag_id: nil)
        @practice_ptag_relation.valid?
        expect(@practice_ptag_relation.errors.full_messages).to include('Ptagを入力してください')
      end
    end
  end
end
