require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'validations' do
    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:url)) }
    it { is_expected.to(validate_uniqueness_of(:name)) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:scrape_status).with_values(started: 0, completed: 1) }
  end
end
