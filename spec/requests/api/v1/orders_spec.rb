require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:email) { Faker::Internet.email }
  let(:product1) { create(:product) }
  let(:product2) { create(:product) }

  describe 'GET /api/v1/orders' do
    context 'when request fails' do
      it 'returns status 400' do
        expect_any_instance_of(FetchOrders).to receive(:call).and_raise(RuntimeError, 'Error message')

        get api_v1_orders_path, params: { email: email }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(json['errors']['title']).to eq('RuntimeError')
        expect(json['errors']['detail']).to eq('Error message')
      end
    end

    context 'when request succeeds' do
      before do
        customer = create(:customer, email: email)
        orders = create_list(:order, 2, customer: customer)
      end

      it 'returns status 200' do
        expect_any_instance_of(FetchOrders).to receive(:call).once.and_call_original

        get api_v1_orders_path, params: { email: email }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json['results'].count).to eq(2)
      end
    end
  end

  describe 'POST /api/v1/orders' do
    context 'when request fails' do
      it 'returns status 400' do
        expect_any_instance_of(CreateOrder).to receive(:call).and_raise(RuntimeError, 'Error message')

        post api_v1_orders_path, params: { email: email }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(json['errors']['title']).to eq('RuntimeError')
        expect(json['errors']['detail']).to eq('Error message')
      end
    end

    context 'when request succeeds' do
      it 'returns status 201' do
        expect_any_instance_of(CreateOrder).to receive(:call).and_call_original

        post api_v1_orders_path, params: {
          email: email,
          order: [
            { product_id: product1.id, qty: 1.5, unit: 'pound' },
            { product_id: product2.id, qty: 100, unit: 'count' }
          ]
        }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(201)
        expect(json['order']).to be_present
      end
    end
  end
end
