# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Amenity, type: :model do
  describe 'associations' do
    it { is_expected.to(have_and_belong_to_many(:hotels)) }
  end

  describe 'validations' do
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:category)) }

    describe 'combination of name and category' do
      subject { create(:amenity) }

      it { is_expected.to(validate_uniqueness_of(:name).scoped_to(:category)) }
    end
  end
end
