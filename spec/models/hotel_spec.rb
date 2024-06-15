require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe 'associations' do
    it { is_expected.to(belong_to(:location)) }
    it { is_expected.to(have_and_belong_to_many(:amenities)) }
  end

  describe 'validations' do
    it { is_expected.to(validate_presence_of(:hotel_id)) }
    it { is_expected.to(validate_presence_of(:destination_id)) }

    describe 'combination of hotel_id and destination_id' do
      subject { create(:hotel) }

      it { is_expected.to(validate_uniqueness_of(:hotel_id).scoped_to(:destination_id)) }
    end
  end
end
