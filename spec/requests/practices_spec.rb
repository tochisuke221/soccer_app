require 'rails_helper'

RSpec.describe 'Practices', type: :request do
  describe 'GET #index' do
    before do
      @practice = FactoryBot.create(:practice)
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのタイトルが存在する' do
      get root_path
      expect(response.body).to include(@practice.title)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのタグがある' do
      get root_path
      expect(response.body).to include(@practice.ptags[0].name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get root_path
      expect(response.body).to include('検索')
    end
  end
end
