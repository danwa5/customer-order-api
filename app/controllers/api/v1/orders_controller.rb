module Api
  module V1
    class OrdersController < ApplicationController
      # GET /api/v1/orders
      def index
        orders = FetchOrders.new(email: customer_email).call
        serializer = OrderSerializer.new(orders).serializable_hash

        render json: { results: serializer[:data] }, status: :ok
      rescue Exception => e
        render json: { errors: { title: e.class.to_s, code: '400', detail: e.message } }, status: :bad_request
      end

      # POST /api/v1/orders
      def create
        order = CreateOrder.new(email: customer_email, order_data: order_data).call
        serializer = OrderSerializer.new(order).serializable_hash

        render json: { order: serializer[:data] }, status: :created
      rescue Exception => e
        render json: { errors: { title: e.class.to_s, code: '400', detail: e.message } }, status: :bad_request
      end

      private

      def order_params
        @order_params ||= params.permit(:email, :order => [:product_id, :qty, :unit]).to_h
      end

      def customer_email
        order_params.fetch('email', nil)
      end

      def order_data
        order_params.fetch('order', [])
      end
    end
  end
end
