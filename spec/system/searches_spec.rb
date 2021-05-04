require 'rails_helper'

RSpec.describe "Searches", type: :system do
  before do
    @user=FactoryBot.create(:user)
    @practice=FactoryBot.create(:practice)
  end
 describe '投稿検索機能' do
   context '検索できる時' do
     it 'ログインユーザはトップページの検索窓口から任意のワードを入力して、投稿を検索することができる' do
       sign_in(@user)
       fill_in "keyword",with: @practice.title
       click_on "検索"
       expect(current_path).to eq(search_practices_path)
       expect(page).to have_content(@practice.title)
       expect(page).to have_content("一覧に戻る")
     end
     it '検索条件に一致した投稿がない場合は、検索結果が0件である旨を表示する' do
      sign_in(@user)
      fill_in "keyword",with:""
      click_on "検索"
      expect(current_path).to eq(search_practices_path)
      expect(page).to have_content("検索結果は0件です")
      expect(page).to have_content("一覧に戻る")
     end
   end
   context '検索できない時' do
     it '未ログインユーザは検索したとしても、ログインを求められる' do
       visit root_path
       fill_in "keyword",with: @practice.title
       click_on "検索"
       expect(current_path).to eq(new_user_session_path)
     end
   end
 end
end
