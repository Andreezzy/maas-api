require 'rails_helper'

RSpec.describe 'api/v1/users', type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode({ id: user.id }) }

  describe 'GET /create' do
    it 'returns http status success' do
      get '/api/v1/users', headers: { 'Authorization': "Bearer #{token}" }
      expect(response).to have_http_status(:success)
    end
  end
end
