require 'rails_helper'

RSpec.describe FetchProductSales do
  let(:yesterday) { Date.yesterday.strftime('%Y-%m-%d') }
  let(:today) { Date.today.strftime('%Y-%m-%d') }

  describe '#call' do
    context 'when start_date is invalid' do
      it 'raises an exception' do
        expect {
          described_class.new(start_date: 'foo', end_date: today).call
        }.to raise_error(ArgumentError)
      end
    end

    context 'when end_date is invalid' do
      it 'raises an exception' do
        expect {
          described_class.new(start_date: yesterday, end_date: 'foo').call
        }.to raise_error(ArgumentError)
      end
    end

    context 'when dates are valid' do
      before do
        @product1 = create(:product, name: 'Rib Eye Steak')
        @product2 = create(:product, name: 'Boxed Wine')
        order = create(:order, order_date: today)
        @order_line1 = create(:order_line, order: order, product: @product1)
        @order_line2 = create(:order_line, order: order, product: @product2)
      end

      example do
        results = described_class.new(start_date: yesterday, end_date: today).call
        expect(results.count).to eq(2)

        aggregate_failures '1st result attributes' do
          expect(results[0]['product_id']).to eq(@product2.id)
          expect(results[0]['product_name']).to eq(@product2.name)
          expect(results[0]['date_part']).to be_present
          expect(results[0]['total_quantity']).to eq(sprintf('%.2f', @order_line2.quantity))
        end

        aggregate_failures '2nd result attributes' do
          expect(results[1]['product_id']).to eq(@product1.id)
          expect(results[1]['product_name']).to eq(@product1.name)
          expect(results[1]['date_part']).to be_present
          expect(results[1]['total_quantity']).to eq(sprintf('%.2f', @order_line1.quantity))
        end
      end
    end
  end

  describe '#date_field' do
    context 'when unit is "day"' do
      subject { described_class.new(start_date: yesterday, end_date: today, unit: 'day') }
      example do
        expect(subject.send(:date_field)).to eq("DATE_PART('dow', o.order_date) as date_part")
      end
    end
    context 'when unit is "week"' do
      subject { described_class.new(start_date: yesterday, end_date: today, unit: 'week') }
      example do
        expect(subject.send(:date_field)).to eq("DATE_PART('week', o.order_date) as date_part")
      end
    end
    context 'when unit is "month"' do
      subject { described_class.new(start_date: yesterday, end_date: today, unit: 'month') }
      example do
        expect(subject.send(:date_field)).to eq("DATE_PART('month', o.order_date) as date_part")
      end
    end
    context 'when unit is anything else' do
      subject { described_class.new(start_date: yesterday, end_date: today, unit: [nil, 'foo'].sample) }
      example do
        expect(subject.send(:date_field)).to eq("DATE_PART('dow', o.order_date) as date_part")
      end
    end
  end
end
