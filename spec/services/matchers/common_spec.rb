# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Matchers::Common do
  subject { Class.new { extend Matchers::Common } }

  describe '#longest_string' do
    it 'returns the longest string from an array of strings' do
      expect(subject.longest_string(%w[short longer longest])).to eq('longest')
    end

    it 'returns the first element if no strings are present' do
      expect(subject.longest_string([nil, 123, :symbol])).to eq(nil)
    end

    it 'removes duplicates and nil values' do
      expect(subject.longest_string(['short', 'short', nil, 'long'])).to eq('short')
    end
  end

  describe '#more_detailed_float' do
    it 'returns the float with more decimal places' do
      expect(subject.more_detailed_float(1.23, 1.2345)).to eq(1.2345)
    end

    it 'returns the other float if one is nil' do
      expect(subject.more_detailed_float(nil, 1.234)).to eq(1.234)
    end

    it 'returns the first float if both are nil' do
      expect(subject.more_detailed_float(nil, nil)).to eq(nil)
    end
  end

  describe '#combine_hashes' do
    it 'merges two hashes and combines values into unique arrays' do
      hash1 = { a: [1, 2], b: [3] }
      hash2 = { a: [2, 3], c: [4] }
      expect(subject.combine_hashes(hash1, hash2)).to eq({ 'a' => [1, 2, 3], 'b' => [3], 'c' => [4] })
    end

    it 'returns the other hash if one is blank' do
      expect(subject.combine_hashes({}, { a: [1] })).to eq({ a: [1] })
    end

    it 'returns an indifferent access hash' do
      result = subject.combine_hashes({ 'a' => [1] }, { a: [2] })
      expect(result[:a]).to eq([1, 2])
      expect(result['a']).to eq([1, 2])
    end
  end

  describe '#combine_array' do
    it 'combines two arrays and removes duplicates and nil values' do
      expect(subject.combine_array([1, 2], [2, 3, nil])).to eq([1, 2, 3])
    end

    it 'returns the other array if one is nil' do
      expect(subject.combine_array(nil, [1, 2])).to eq([1, 2])
    end

    it 'returns an empty array if both are nil' do
      expect(subject.combine_array(nil, nil)).to eq([])
    end
  end
end
