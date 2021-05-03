require 'rails_helper'

RSpec.describe "Games", type: :system do
  describe '新規投稿' do
    before do
      @user=FactoryBot.create(:user)
      @game=FactoryBot.build(:game)
    end
    context '新規投稿できるとき' do
      it 'ユーザは試合募集一覧の中にあるリンクをクリックして、新規投稿ページから正しい情報を入力すると投稿でき,それが一覧に表示される' do
        sign_in(@user)
        expect(page).to have_link("試合募集")
        visit games_path
        expect(page).to have_link("開催者として募集したい方はこちら")
        click_on("開催者として募集したい方はこちら")
        expect(current_path).to eq(new_game_path)
        fill_in 'game_title', with: @game.title
        find("#game_gameday_1i").find("option[value='#{@game.gameday.year}']").select_option
        find("#game_gameday_2i").find("option[value='#{@game.gameday.month}']").select_option
        find("#game_gameday_3i").find("option[value='#{@game.gameday.day}']").select_option
        find("#game_gameday_4i").find("option[value='#{@game.gameday.strftime("%H")}']").select_option
        find("#game_gameday_5i").find("option[value='#{@game.gameday.strftime("%M")}']").select_option
        fill_in 'game_location', with: @game.location
        find("#game_gametime_id").find("option[value='#{@game.gametime_id}']").select_option
        find("#game_gamenum_id").find("option[value='#{@game.gamenum_id}']").select_option
        find("#game_level_id").find("option[value='#{@game.level_id}']").select_option
        find('input[name="commit"]').click
        expect(current_path).to eq(games_path)
        expect(page).to have_content("募集に成功しました")
        expect(page).to have_content(@game.title)
      end
    end
    context '新規投稿できないとき' do
      it 'ユーザは試合募集一覧の中にあるリンクをクリックして、新規投稿ページから誤った情報を入力すると投稿できない' do
        sign_in(@user)
        expect(page).to have_link("試合募集")
        visit games_path
        expect(page).to have_link("開催者として募集したい方はこちら")
        click_on("開催者として募集したい方はこちら")
        expect(current_path).to eq(new_game_path)
        fill_in 'game_title', with: ""
        find("#game_gameday_1i").find("option[value='2021']").select_option
        find("#game_gameday_2i").find("option[value='4']").select_option
        find("#game_gameday_3i").find("option[value='5']").select_option
        find("#game_gameday_4i").find("option[value='16']").select_option
        find("#game_gameday_5i").find("option[value='00']").select_option
        fill_in 'game_location', with: ""
        find("#game_gametime_id").find("option[value='1']").select_option
        find("#game_gamenum_id").find("option[value='1']").select_option
        find("#game_level_id").find("option[value='1']").select_option
        find('input[name="commit"]').click
        expect(current_path).to eq(games_path)
        expect(page).to have_content("募集投稿に失敗しました")
        expect(page).to have_content("試合会場を入力してください")
        expect(page).to have_content("タイトルを入力してください")
        expect(page).to have_content("試合時間を入力してください")
        expect(page).to have_content("試合本数を入力してください")
        expect(page).to have_content("相手に求めるレベルを入力してください")
      end
      it 'ユーザがログインしてないとリンクがないので遷移できない' do
        visit games_path
        expect(current_path).to eq(new_user_session_path)
      end
    end

    describe '投稿削除' do
     before do
      @user=FactoryBot.create(:user)
      @game=FactoryBot.create(:game,user_id:@user.id)   
     end
     context '投稿削除できるとき' do
      it 'ユーザはログイン後、自身の投稿であれば詳細ページの削除ボタンを押して削除できる' do
        sign_in(@user)
        visit game_path(@game)
        expect(page).to have_content("削除")
        expect{
          click_on "削除"
        }.to change{Game.count}.by(-1)
        expect(current_path).to eq(games_path)
        expect(page).to have_no_content(@game.title)
      end
     end
     context '投稿削除できないとき' do
       it 'ユーザは他人の投稿を削除できない' do
         @another=FactoryBot.create(:user)
         sign_in(@another)
         visit game_path(@game)
         expect(page).to have_no_content("削除")
       end
     end
    end  
    describe '試合申し込み' do
      before do
        @user=FactoryBot.create(:user)
        @game=FactoryBot.create(:game,user_id:@user.id)   
       end
      context '試合の申し込みができる時' do
       it 'ユーザは田ユーザが投稿した試合募集の詳細ページから試合の申し込みができる' do
         @another=FactoryBot.create(:user)
         sign_in(@another)
         visit game_path(@game)
         expect(page).to have_content("申込")
         click_on "申込"
         expect(current_path).to eq(user_path(@user))
         expect(page).to have_content("申し込みを完了しました!!!開催者にDMを送りましょう")
         visit games_path
         expect(page).to have_no_content(@game.title)
       end
      end
      context '試合の申し込みができない時' do
       it 'ユーザは自身が投稿した試合募集には申し込みができない' do
         sign_in(@user)
         visit (game_path(@game))
         expect(page).to have_no_content("申込")
       end
      end
    end
  end
end
