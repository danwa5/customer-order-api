require 'rails_helper'

RSpec.describe OrderLine, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:order_id) }
    it { is_expected.to validate_presence_of(:product_id) }
    it { is_expected.to validate_inclusion_of(:unit).in_array(%w(count pound ounce)) }
  end
end
