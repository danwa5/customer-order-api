require 'rails_helper'

RSpec.describe FetchOrders do
  let(:customer) { create(:customer, email: 'foo@gmail.com') }

  subject { described_class.new(email: customer.email) }

  describe '#call' do
    context 'when customer has no orders' do
      it { expect(subject.call).to be_empty }
    end

    context 'when customer has orders' do
      example do
        order1 = create(:order, customer: customer, order_date: 2.days.ago)
        order2 = create(:order, customer: customer, order_date: Date.today)

        expect(subject.call).to eq([order2, order1])
      end
    end
  end
end
