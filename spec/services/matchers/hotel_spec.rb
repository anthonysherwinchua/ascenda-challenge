# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Matchers::Hotel do
  let(:hotel) do
    create(:hotel,
           name: 'Old Hotel',
           description: 'Old but longer description',
           images: { 'front' => ['old_front.jpg'] },
           booking_conditions: ['no pets'])
  end
  let(:new_attributes) do
    {
      name: 'New Hotel',
      description: 'New Description',
      images: {
        'front' => ['new_front.jpg'],
        'back' => ['new_back.jpg']
      },
      booking_conditions: ['no smoking']
    }
  end

  subject { described_class.new(hotel, new_attributes) }

  describe '#attributes' do
    it 'returns the combined attributes' do
      expected_attributes = {
        name: 'New Hotel',
        description: 'Old but longer description',
        images: { 'front' => ['old_front.jpg', 'new_front.jpg'], 'back' => ['new_back.jpg'] },
        booking_conditions: ['no pets', 'no smoking']
      }
      expect(subject.attributes).to eq(expected_attributes)
    end
  end

  describe '#name' do
    it 'returns the longest name' do
      expect(subject.send(:name)).to eq('New Hotel')
    end
  end

  describe '#description' do
    it 'returns the longest description' do
      expect(subject.send(:description)).to eq('Old but longer description')
    end
  end

  describe '#images' do
    it 'returns the combined images' do
      expect(subject.send(:images)).to eq({ 'front' => ['old_front.jpg', 'new_front.jpg'], 'back' => ['new_back.jpg'] })
    end
  end

  describe '#booking_conditions' do
    it 'returns the combined booking conditions' do
      expect(subject.send(:booking_conditions)).to eq(['no pets', 'no smoking'])
    end
  end
end
