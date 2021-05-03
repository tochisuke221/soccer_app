require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET #index" do
    before do
     @game=FactoryBot.create(:game)
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get games_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのタイトルが存在する' do 
      get games_path
      expect(response.body).to include(@game.title)
    end
    it 'indexアクションにリクエストするとレスポンスに新規募集へのリンクが存在するが存在する' do
      get games_path
      expect(response.body).to include('開催者として募集したい方はこちら')
    end
  end
end
