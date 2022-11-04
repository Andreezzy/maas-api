module Api
  module V1
    class ApiController < ApplicationController
      include JwtAuthenticable

      before_action :authenticate_user
    end
  end
end
