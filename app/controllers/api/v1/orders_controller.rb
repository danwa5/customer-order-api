module Api
  module V1
    class OrdersController < ApplicationController
      # GET /api/v1/orders
      def index
        orders = FetchOrders.new(email: customer_email).call
        serializer = OrderSerializer.new(orders).serializable_hash

        render json: { results: serializer[:data] }, status: :ok
      rescue Exception => e
        render json: { errors: [ { title: e.class.to_s, code: '400', detail: e.message } ] }, status: :bad_request
      end

      # POST /api/v1/orders
      def create
        order = CreateOrder.new(email: customer_email, order_data: order_data).call

        if order
          render json: {}, status: :created
        else
          render json: {}, status: '400'
        end
      rescue Exception => e
        render json: { errors: [ { title: e.class.to_s, code: '400', detail: e.message } ] }, status: :bad_request
      end

      private

      def customer_email
        params.to_unsafe_h.fetch('email')
      end

      def order_data
        params.to_unsafe_h.fetch('order', [])
      end
    end
  end
end
