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

      def start_date
        params.fetch('start_date')
      end

      def end_date
        params.fetch('end_date')
      end

      def unit
        params.fetch('unit', 'date')
      end
    end
  end
end
