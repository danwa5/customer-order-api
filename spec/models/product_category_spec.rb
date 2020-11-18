require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:category) }
  end
end
