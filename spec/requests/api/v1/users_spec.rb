require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'lists all the users' do
      get '/api/v1/users'
      expect(response.status).to eq(401)
    end
  end
end
