require 'rails_helper'

RSpec.describe "Practices",js: true, type: :system do
  before do
    @user=FactoryBot.create(:user)
  end
  describe '新規投稿' do
    before do
      @practices_ptag=FactoryBot.build(:practices_ptag)
    end
    context '新規練習投稿ができるとき' do
      it 'ログインして、投稿画面にいき、正しい情報を入力するとトップページでその投稿が表示される' do
         sign_in(@user)
         expect(page).to have_content("投稿する")
         visit new_practice_path
         fill_in 'practices_ptag_title', with: @practices_ptag.title
         find("#practices_ptag_category_id").find("option[value='#{@practices_ptag.category_id}']").select_option
         fill_in 'lesson-content', with: @practices_ptag.content
         find("#practices_ptag_hardlevel_id").find("option[value='#{@practices_ptag.hardlevel_id}']").select_option
         fill_in 'practices_ptag_name', with: @practices_ptag.name
         expect{
           find('input[name="commit"]').click
         }.to change {Practice.count}.by(1).and change { Ptag.count }.by(1)
         expect(current_path).to eq(root_path)
         expect(page).to have_content("投稿に成功しました")
         expect(page).to have_content(@practices_ptag.title)
      end
    end
    context '新規練習投稿できないとき' do
      it 'ログインして、投稿画面で正しくない情報を入力すると同じページにてエラー文が表示される' do
        sign_in(@user)
         expect(page).to have_content("投稿する")
         visit new_practice_path
         fill_in 'practices_ptag_title', with: ""
         find("#practices_ptag_category_id").find("option[value='1']").select_option
         fill_in 'lesson-content', with: ""
         find("#practices_ptag_hardlevel_id").find("option[value='1']").select_option
         fill_in 'practices_ptag_name', with: ""
         find('input[name="commit"]').click
         expect(page).to have_content("タイトルを入力してください")
         expect(page).to have_content("練習の内容を入力してください")
         expect(page).to have_content("タグを入力してください")
         expect(page).to have_content("練習カテゴリーを入力してください")
         expect(page).to have_content("負荷のレベルを入力してください")
      end
    end
  end
  describe '投稿編集' do
    before do
      @practice=FactoryBot.create(:practice,user_id:@user.id)
    end
    context '投稿編集できるとき' do
      it '自身の投稿詳細ページの編集ボタンから編集ページにいき、正しく情報が入力されていれば編集できる' do
        sign_in(@user)
        expect(page).to have_content(@practice.title)
        visit practice_path(@practice)
        expect(page).to have_content("編集")
        click_on "編集"
        expect(current_path).to eq(edit_practice_path(@practice))
        fill_in 'practices_ptag_title', with: "変更した"
        find("#practices_ptag_category_id").find("option[value='#{@practice.category_id}']").select_option
        fill_in 'lesson-content', with: "変更した"
        find("#practices_ptag_hardlevel_id").find("option[value='#{@practice.hardlevel_id}']").select_option
        fill_in 'practices_ptag_name', with: @practice.ptags[0].name
        find('input[name="commit"]').click
        expect(current_path).to eq(practice_path(@practice))
        expect(page).to have_content("変更した")
        expect(page).to have_content("編集に成功しました")
        visit root_path
        expect(page).to have_content("変更した")
      end
      it 'ログイン後、トップページの自身の投稿にある歯車をクリックして編集ページにいって、正しく情報が入力されていれば編集できる' , js: true do
        sign_in(@user)
        expect(page).to have_content(@practice.title)
        find(".gear_icon").hover
        expect(page).to have_link '編集',href: edit_practice_path(@practice)
        visit edit_practice_path(@practice)
        fill_in 'practices_ptag_title', with: "変更した"
        find("#practices_ptag_category_id").find("option[value='#{@practice.category_id}']").select_option
        fill_in 'lesson-content', with: "変更した"
        find("#practices_ptag_hardlevel_id").find("option[value='#{@practice.hardlevel_id}']").select_option
        fill_in 'practices_ptag_name', with: @practice.ptags[0].name
        find('input[name="commit"]').click
        expect(current_path).to eq(practice_path(@practice))
        expect(page).to have_content("変更した")
        expect(page).to have_content("編集に成功しました")
        visit root_path
        expect(page).to have_content("変更した")
      end
    end
    context '投稿編集できないとき' do
      it 'ログイン後、編集ページで、誤った情報が入力されているとエラー' do
        sign_in(@user)
        expect(page).to have_content(@practice.title)
        find(".gear_icon").hover
        expect(page).to have_link '編集',href: edit_practice_path(@practice)
        visit edit_practice_path(@practice)
        fill_in 'practices_ptag_title', with: ""
        find("#practices_ptag_category_id").find("option[value='1']").select_option
        fill_in 'lesson-content', with: ""
        find("#practices_ptag_hardlevel_id").find("option[value='1']").select_option
        fill_in 'practices_ptag_name', with: ""
        find('input[name="commit"]').click
        expect(page).to have_content("編集に失敗しました")
        expect(page).to have_content("練習の内容を入力してください")
        expect(page).to have_content("タグを入力してください")
        expect(page).to have_content("練習カテゴリーを入力してください")
        expect(page).to have_content("負荷のレベルを入力してください")
      end
      it '自分以外の投稿には歯車がないので編集できない' do
        @another=FactoryBot.create(:user)
        sign_in(@another)
        expect(page).to have_no_selector ".gear_icon"
      end
      it '自分以外の投稿詳細ページには編集ボタンがないので削除できない' do
        @another=FactoryBot.create(:user)
        sign_in(@another)
        visit practice_path(@practice)
        expect(page).to have_no_content("編集")
      end
    end
  end
  describe '投稿削除' do 
    before do
      @practice=FactoryBot.create(:practice,user_id:@user.id)
    end
    context '投稿を削除できる' do
      it '自身の投稿詳細ページの削除ボタンから削除する' do
        sign_in(@user)
        expect(page).to have_content(@practice.title)
        visit practice_path(@practice)
        expect(page).to have_content("削除")
        expect{
          click_on("削除")
          expect(page.accept_confirm).to eq "本当に削除しますか?"
          sleep 0.5
        }.to change{Practice.count}.by(-1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("削除に成功しました")
      end
      it 'トップページの歯車から削除ボタン押して削除する' do
        sign_in(@user)
        expect(page).to have_content(@practice.title)
        find(".gear_icon").hover
        expect(page).to have_link '削除',href: practice_path(@practice)
        expect{
          click_on("削除")
          expect(page.accept_confirm).to eq "本当に削除しますか?"
          sleep 0.5
        }.to change{Practice.count}.by(-1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("削除に成功しました")
      end
    context '削除できないとき' do
      it '自分以外の投稿は歯車がないので削除できない' do
        @another=FactoryBot.create(:user)
        sign_in(@another)
        expect(page).to have_no_selector ".gear_icon"
      end
      it '自分以外の投稿詳細ページには削除ボタンがないので削除できない' do
        @another=FactoryBot.create(:user)
        sign_in(@another)
        visit practice_path(@practice)
        expect(page).to have_no_content("削除")
      end
    end
    end
  end
end
