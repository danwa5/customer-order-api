require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:product_categories) }
    it { is_expected.to have_many(:categories).through(:product_categories) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:list_price) }
  end
end
