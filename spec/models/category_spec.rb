require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:product_categories) }
    it { is_expected.to have_many(:products).through(:product_categories) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
