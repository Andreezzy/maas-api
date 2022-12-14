module Api
  module V1
    class CompaniesController < Api::V1::ApiController
      before_action :set_company, only: %i[ show update destroy ]

      # GET /companies
      def index
        @companies = Company.all.includes(:schedules)

        # render json: @companies
        render json: Panko::ArraySerializer.new(@companies, each_serializer: CompanySerializer).to_json
      end

      # GET /companies/1
      def show
        render json: @company
      end

      # POST /companies
      def create
        @company = Company.new(company_params)

        if @company.save
          render json: @company, status: :created
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /companies/1
      def update
        if @company.update(company_params)
          render json: @company
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      # DELETE /companies/1
      def destroy
        @company.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_company
        @company = Company.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def company_params
        params.require(:company).permit(:name, :description, :avatar)
      end
    end
  end
end
