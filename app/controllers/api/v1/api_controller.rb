module Api
  module V1
    class ApiController < ApplicationController
      include JwtAuthenticable

      before_action :authenticate_user

      def check_jwt
        render json: {
          message: 'authenticated',
          data: @current_user
        }, status: :ok
      end
    end
  end
end
