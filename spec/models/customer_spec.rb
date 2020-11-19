require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { build(:customer) }

  describe 'relationships' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
