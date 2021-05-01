require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録・更新登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '登録できるとき' do
      it 'すべての情報が正しく存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nameが9文字以下であれば登録できる' do
        @user.name="123456789"
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password="123456"
        @user.password_confirmation=@user.password
        expect(@user).to be_valid
      end
      it 'phone_numが整数11桁で入力されていれば登録できる' do
        @user.phone_num='09012341234'
        expect(@user).to be_valid
      end
    end
    context '登録できないとき' do
      it 'nameが空では登録できない' do
        @user.name=''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください");
      end
      it 'nameが10文字以上では登録できない' do
        @user.name='やまとみことのたける'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は9文字以内で入力してください");
      end
      it 'emailが空では登録できない' do
        @user.email=''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください");
      end
      it '重複したemailが存在する場合登録できない' do
        another=FactoryBot.create(:user)
        @user.email=another.email
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスはすでに存在します");
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password="12345"
        @user.password_confirmation="12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください");
      end
      it 'passwordが空では登録できない' do
        @user.password=""
        @user.password_confirmation=""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください");
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password="123456"
        @user.password_confirmation=""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません");
      end
      it 'passwordとpassword_confirmationが一致してないと登録できない' do
        @user.password="123456"
        @user.password_confirmation="abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません");
      end
      it 'team_nameが空では登録できない' do
        @user.team_name=""
        @user.valid?
        expect(@user.errors.full_messages).to include("高校名（チーム名）を入力してください");
      end
      it 'team_nameが21文字以上では登録できない' do
        @user.team_name="チーム絶対にすげえエンジニアになるんだぜ！社会貢献するんだああ！！！！！"
        @user.valid?
        expect(@user.errors.full_messages).to include("高校名（チーム名）は20文字以内で入力してください");
      end
      it 'career_idが1では登録できない' do
        @user.career_id="1"
        @user.valid?
        expect(@user.errors.full_messages).to include("教師歴を入力してください");
      end
      it 'phone_numが11桁で登録できない' do
        @user.phone_num="0901234123"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は正しくありません");
      end
      it 'phone_numが13桁で登録できない' do
        @user.phone_num="090123412345"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は正しくありません");
      end
      it 'phone_numに数字以外が入力されていると登録できない' do
        @user.phone_num="電話番号：09012345123"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は正しくありません");
      end
      it 'phone_numにハイフンがあると登録できない' do
        @user.phone_num="090-1234-1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は正しくありません");
      end
    end
  end
end
