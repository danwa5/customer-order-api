require 'rails_helper'

RSpec.describe CreateOrder do
  let(:email) { Faker::Internet.email }
  let(:product1) { create(:product) }
  let(:product2) { create(:product) }

  let(:order_data) do
    [
      { 'product_id' => product1.id, 'qty' => 5 },
      { 'product_id' => product2.id, 'qty' => 10 }
    ]
  end

  describe '#call' do
    context 'when email is missing' do
      it 'raises exception' do
        expect {
          described_class.new(email: nil, order_data: order_data).call
        }.to raise_error('Insufficient order data')
      end
    end

    context 'when order data is missing' do
      it 'raises exception' do
        expect {
          described_class.new(email: email, order_data: nil).call
        }.to raise_error('Insufficient order data')
      end
    end

    context 'when required data is provided' do
      it 'returns the order' do
        order = described_class.new(email: email, order_data: order_data).call

        aggregate_failures 'order attributes' do
          expect(order.customer_id).to be_present
          expect(order.order_date).to be_present
        end

        line1 = order.order_lines.first
        aggregate_failures '1st order line attributes' do
          expect(line1.order_id).to eq(order.id)
          expect(line1.product_id).to eq(product1.id)
          expect(line1.product_name).to eq(product1.name)
          expect(line1.quantity).to eq(5)
        end

        line2 = order.order_lines.last
        aggregate_failures '2nd order line attributes' do
          expect(line2.order_id).to eq(order.id)
          expect(line2.product_id).to eq(product2.id)
          expect(line2.product_name).to eq(product2.name)
          expect(line2.quantity).to eq(10)
        end
      end
    end
  end
end
