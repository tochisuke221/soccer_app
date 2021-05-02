require 'rails_helper'

RSpec.describe Ptag, type: :model do
  describe 'タグが保存されない場合' do
    before do 
      @ptag=FactoryBot.create(:ptag)
    end
    it '重複したタグ名は保存されない' do
      another_ptag=FactoryBot.build(:ptag)
      another_ptag.name=@ptag.name
      another_ptag.valid?
      expect(another_ptag.errors.full_messages).to include("Nameはすでに存在します")
    end
  end
end
