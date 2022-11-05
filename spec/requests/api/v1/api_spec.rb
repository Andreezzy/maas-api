require 'rails_helper'

RSpec.describe 'api/v1/', type: :request do
  describe 'GET /api/v1/check_jwt' do
    context 'without params' do
      it 'returns http status unauthorized' do
        get '/api/v1/check_jwt'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with params' do
      let(:user) { create(:user) }
      let(:token) { JsonWebToken.encode({ id: user.id }) }

      context 'with valid token' do
        let(:body) { JSON.parse(response.body) }

        before { get '/api/v1/check_jwt', headers: { 'Authorization': "Bearer #{token}" } }

        it 'returns http status success' do
          expect(response).to have_http_status(:success)
        end
        it 'returns a payload with the user email' do
          expect(body['data']['email']).to eq(user.email)
        end
      end

      context 'with invalid token' do
        it 'returns http status unauthorized' do
          get '/api/v1/check_jwt', headers: { 'Authorization': "Bearer #{token[1..-1]}" }
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
