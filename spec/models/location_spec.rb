require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "validations" do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:zipcode) }
  end
end
