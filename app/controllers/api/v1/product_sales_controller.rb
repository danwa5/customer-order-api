module Api
  module V1
    class ProductSalesController < ApplicationController
      # GET /api/v1/product_sales
      def index
        data = FetchProductSales.new(start_date: start_date, end_date: end_date, unit: unit).call
        render json: { results: data }, status: :ok
      rescue Exception => e
        render json: { errors: { title: e.class.to_s, code: '400', detail: e.message } }, status: :bad_request
      end

      private

      def reporting_params
        @reporting_params ||= params.permit(:start_date, :end_date, :unit).to_h
      end

      def start_date
        reporting_params.fetch('start_date', nil)
      end

      def end_date
        reporting_params.fetch('end_date', nil)
      end

      def unit
        reporting_params.fetch('unit', nil)
      end
    end
  end
end
