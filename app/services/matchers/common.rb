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

      decimal_places1 = float1.to_s.split('.').last&.size || 0
      decimal_places2 = float2.to_s.split('.').last&.size || 0

      if decimal_places1 > decimal_places2
        float1
      else
        float2
      end
    end

    def combine_hashes(hash1, hash2)
      return hash2 if hash1.blank?
      return hash1 if hash2.blank?

      hash1 = hash1.with_indifferent_access
      hash2 = hash2.with_indifferent_access

      merged_hash = {}

      hash1.each do |key, value|
        merged_hash[key] = value
      end

      hash2.each do |key, value|
        if merged_hash[key]
          merged_hash[key] += value
        else
          merged_hash[key] = value
        end
      end

      merged_hash.transform_values! do |values|
        values.uniq
      end

      merged_hash.with_indifferent_access
    end

    def combine_array(array1, array2)
      (Array(array1) + Array(array2)).compact.uniq
    end
  end
end
