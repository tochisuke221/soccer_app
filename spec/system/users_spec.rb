require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザ新規登録' do 
    before do
      @user=FactoryBot.build(:user)
    end
    context 'ユーザが新規登録できる時' do
      it '正しい情報を入力すれば新規登録ができて、トップページに移動する' do 
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content("新規登録")
        # 新規登録ページへ移動する
        visit new_user_registration_path
        # ユーザー情報を入力する
        fill_in 'user_name', with: @user.name
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
        fill_in 'user_password_confirmation', with: @user.password_confirmation
        fill_in 'user_phone_num', with: @user.phone_num
        fill_in 'user_team_name', with: @user.team_name
        find("#user_career_id").find("option[value='#{@user.career_id}']").select_option
        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{find('input[name="commit"]').click}.to change{User.count}.by(1)
        # トップページへ遷移したことを確認する
        expect(current_path).to eq(root_path)
        # クリックするとログアウトボタンが表示されることを確認する
        expect(find('.dropdown').click).to have_content("ログアウト")
        # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end
    context 'ユーザが新規登録できない時' do
      it '誤った情報では新規登録できず、同ページにてエラー文が記載される' do
        # トップページに移動する
        visit root_path
        # トップページにサインアップページへ遷移するボタンがあることを確認する
        expect(page).to have_content("新規登録")
        # 新規登録ページへ移動する
        visit new_user_registration_path
        #正しくないユーザ情報を入力する
        fill_in 'user_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        fill_in 'user_phone_num', with: ''
        fill_in 'user_team_name', with: ''
        find("#user_career_id").find("option[value='1']").select_option
        #登録ボタンを押してもユーザモデルのカウントは上がらないことを確認
        expect{find('input[name="commit"]').click}.to change{User.count}.by(0)
        #同ページにてエラー文が発生することを確認
        expect(page).to have_content("メールアドレスを入力してください")
        expect(page).to have_content("パスワードを入力してください")
        expect(page).to have_content("名前を入力してください")
        expect(page).to have_content("高校名（チーム名）を入力してください")
        expect(page).to have_content("電話番号を入力してください")
        expect(page).to have_content("電話番号は正しくありません")
        expect(page).to have_content("教師歴を入力してください")
      end
    end
  end
  describe 'ユーザ編集' do
    before do 
      @user=FactoryBot.create(:user)
    end
    context 'ユーザの編集ができるとき' do
      it '正しい情報を入力すれば、編集を完了し、ユーザ詳細ページでその内容が更新されている' do
        sign_in(@user)
        visit user_path(@user)
        expect(page).to have_content("編集する")
        visit edit_user_path(@user)
        fill_in 'user_name', with: "変更した名前"
        fill_in 'user_phone_num', with: "09091231234"
        fill_in 'user_team_name', with: "変更したチーム名"
        find("#user_career_id").find("option[value='3']").select_option
        click_on ("更新する")
        expect(current_path).to eq(user_path(@user))
        expect(page).to have_content("変更した名前")
        expect(page).to have_content("変更したチーム名")
        expect(page).to have_content("4年目〜6年目")
      end
    end
    context 'ユーザの編集ができないとき' do
      it '正しく情報が入力されていないと、編集ページにてエラー文が表示される' do
        sign_in(@user)
        visit user_path(@user)
        expect(page).to have_content("編集する")
        visit edit_user_path(@user)
        fill_in 'user_name', with: ""
        fill_in 'user_phone_num', with: ""
        fill_in 'user_team_name', with: ""
        find("#user_career_id").find("option[value='1']").select_option
        click_on ("更新する")
        expect(current_path).to eq(user_path(@user))
        expect(page).to have_content("名前を入力してください")
        expect(page).to have_content("高校名（チーム名）を入力してください")
        expect(page).to have_content("電話番号を入力してください")
        expect(page).to have_content("電話番号は正しくありません")
        expect(page).to have_content("教師歴を入力してください")
      end
    end
  end
  describe 'ユーザログイン' do
    before do
      @user=FactoryBot.create(:user)
    end
    context 'ログインができる時' do
      it '正しい情報を入力すればログインができ、トップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ移動する
        visit new_user_session_path
        # ユーザー情報を入力する
        sign_in(@user)
        # クリックするとログアウトボタンが表示されることを確認する
        expect(find('.dropdown').click).to have_content("ログアウト")
        # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_link ('ログイン')
      end
    end
    context 'ログインができない時' do
      it '誤った情報を入力するとログインができず、同ページにてエラー文が表示される' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ移動する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in 'user_email', with: ""
        fill_in 'user_password', with: ""
        # サインアップボタンを押す
        find('input[name="commit"]').click
        #ログインページにいることを確認
        expect(current_path).to eq(new_user_session_path)
        #エラー文が表示されることを確認
        expect(page).to have_content("メールアドレスまたはパスワードが違います。")
      end
    end
  end
  describe 'ユーザログアウト' do
    before do
      @user=FactoryBot.create(:user)
    end
    context 'ログアウトできるとき' do
      it 'ログイン状態から、ログアウトボタンを押すとログアウトできる' do
       #ログインする
       sign_in(@user)
       #クリックするとログアウトボタンがあることを確認する
       expect(find('.dropdown').click).to have_content("ログアウト")
       #ログアウトボタンを押すとトップページ偽にすること確認
       click_on("ログアウト")
       expect(current_path).to eq(root_path)
       #トップページには新規登録ボタン、ログインボタンがあることを確認する
       expect(page).to have_content("新規登録")
       expect(page).to have_content("ログイン")
      end  
    end
    context 'ログアウトできないとき' do
      it 'ログアウト状態から、destroy_user_session_pathにアクセスしてもログインできず、ログインページに変異する' do
        visit destroy_user_session_path
        expect(current_path).to eq(new_user_session_path)
        expect(page).to have_content("ログインもしくはアカウント登録してください。")
      end
    end
  end 
  describe '退会' do
    before do
      @user=FactoryBot.create(:user)
    end
    context '退会できる時' do
      it 'ログインして、マイページから退会ボタンを押して、OKを押すと退会できる' do
        sign_in(@user)
        visit user_path(@user)
        expect{
          click_on("退会する")
          expect(page.accept_confirm).to eq "本当に退会しますか?退会後は全てのデータが削除されます。"
          sleep 0.5
        }.to change{User.count}.by(-1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("退会処理を完了しました。再度ログインする場合は新規登録をしてください")
      end
    end
  end
end
