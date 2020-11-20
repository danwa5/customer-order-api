require 'rails_helper'

RSpec.describe 'Product Sales', type: :request do
  let(:start_date) { 1.week.ago.strftime('%Y-%m-%d') }
  let(:end_date) { Date.tomorrow.strftime('%Y-%m-%d') }

  describe 'GET /api/v1/product_sales' do
    context 'when request fails' do
      it 'returns status 400' do
        expect_any_instance_of(FetchProductSales).to receive(:call).once.and_raise(RuntimeError, 'Error message')

        get api_v1_product_sales_path, params: { start_date: start_date, end_date: end_date }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(400)
        expect(json['errors']['title']).to eq('RuntimeError')
        expect(json['errors']['detail']).to eq('Error message')
      end
    end

    context 'when request succeeds' do
      before do
        order = create(:order)
        create(:order_line, order: order)
      end
      it 'returns status 200' do
        expect_any_instance_of(FetchProductSales).to receive(:call).once.and_call_original

        get api_v1_product_sales_path, params: { start_date: start_date, end_date: end_date, unit: 'week' }

        json = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(json['results'].count).to eq(1)
      end
    end
  end
end
