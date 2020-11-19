require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:order_lines) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:order_date) }
    it { is_expected.to validate_inclusion_of(:status).in_array(described_class::ORDER_STATUSES) }
  end

  describe 'ORDER_STATUSES' do
    it { expect(described_class::ORDER_STATUSES).to eq(['ready', 'on its way', 'delivered']) }
  end
end
