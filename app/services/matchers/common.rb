# frozen_string_literal: true

module Matchers
  module Common
    def longest_string(strings)
      strings = strings.compact.uniq

      strings = strings.select { |string| string.is_a?(String) }
      return nil if strings.count.zero?
      return strings.first if strings.count == 1

      strings.max_by(&:length)
    end

    def more_detailed_float(float1, float2)
      return float2 if float1.nil?
      return float1 if float2.nil?

      decimal_places1 = decimal_place_count(float1)
      decimal_places2 = decimal_place_count(float2)

      if decimal_places1 > decimal_places2
        float1
      else
        float2
      end
    end

    def decimal_place_count(float)
      float.to_s.split('.').last&.size || 0
    end

    def combine_hashes(hash1, hash2)
      return hash2 if hash1.blank?
      return hash1 if hash2.blank?

      hash1 = hash1.with_indifferent_access
      hash2 = hash2.with_indifferent_access

      merged_hash = merge_hashes(hash1, hash2)
      merged_hash.transform_values!(&:uniq)

      merged_hash.with_indifferent_access
    end

    def merge_hashes(hash1, hash2)
      hash1.merge(hash2) do |_, old_val, new_val|
        Array(old_val) + Array(new_val)
      end
    end

    def combine_array(array1, array2)
      (Array(array1) + Array(array2)).compact.uniq
    end
  end
end
