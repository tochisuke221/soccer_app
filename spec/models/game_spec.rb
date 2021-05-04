require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '試合募集登録' do
    before do
      @game = FactoryBot.build(:game)
    end
    context '登録できる時' do
      it '全ての情報が正しい時' do
        expect(@game).to be_valid
      end
      it '試合会場が30文字以内であれば登録できる' do
        @game.location = '012345678901234567890123456789'
        expect(@game).to be_valid
      end
      it 'タイトルが40文字以内であれば登録できる' do
        @game.title = '0123456789012345678901234567890123456789'
        expect(@game).to be_valid
      end
    end
    context '登録できない時' do
      it '試合日時が空であると保存できない' do
        @game.gameday = ''
        @game.valid?
        expect(@game.errors.full_messages).to include('Gamedayを入力してください')
      end
      it '試合会場が空であると保存できない' do
        @game.location = ''
        @game.valid?
        expect(@game.errors.full_messages).to include('試合会場を入力してください')
      end
      it '試合会場が31文字以上であると保存できない' do
        @game.location = 'この文字列はちょうど31文字です！！！！！！！！！！！！！！！'
        @game.valid?
        expect(@game.errors.full_messages).to include('試合会場は30文字以内で入力してください')
      end
      it 'タイトルが空であると保存できない' do
        @game.title = ''
        @game.valid?
        expect(@game.errors.full_messages).to include('タイトルを入力してください')
      end
      it 'タイトルが41文字以上であると保存できない' do
        @game.title = 'この文字列はちょうど41文字です！！！！！！！！！！！！！！！！！！！！！！！！！'
        @game.valid?
        expect(@game.errors.full_messages).to include('タイトルは40文字以内で入力してください')
      end
      it '試合本数が選択されていないと保存できない' do
        @game.gamenum_id = '1'
        @game.valid?
        expect(@game.errors.full_messages).to include('試合本数を入力してください')
      end
      it '試合時間が選択されていないと保存できない' do
        @game.gametime_id = '1'
        @game.valid?
        expect(@game.errors.full_messages).to include('試合時間を入力してください')
      end
      it '相手に求めるレベルが選択されていないと保存できない' do
        @game.level_id = '1'
        @game.valid?
        expect(@game.errors.full_messages).to include('相手に求めるレベルを入力してください')
      end
      it 'ユーザが紐づいていないと保存できない' do
        @no_user_game = FactoryBot.build(:game, user_id: nil)
        @no_user_game.valid?
        expect(@no_user_game.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
