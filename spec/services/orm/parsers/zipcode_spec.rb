# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orm::Parsers::Zipcode do
  subject { Class.new { extend Orm::Parsers::Zipcode } }

  describe '#zipcode_from' do
    it 'extracts a 6-digit zipcode from an address' do
      address = '123 Abc St, 123456'
      expect(subject.zipcode_from(address)).to eq('123456')
    end

    it 'extracts a 6-digit zipcode with a 4-digit extension from an address' do
      address = '123 Abc St, 123456-7890'
      expect(subject.zipcode_from(address)).to eq('123456-7890')
    end

    it 'returns nil if no zipcode is present' do
      address = '123 Abc St'
      expect(subject.zipcode_from(address)).to be_nil
    end

    it 'returns nil if address is nil' do
      expect(subject.zipcode_from(nil)).to be_nil
    end
  end
end
