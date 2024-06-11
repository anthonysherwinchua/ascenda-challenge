module Matchers
  module Common
    def longest_string(strings)
      strings = strings.compact.uniq

      return strings.first if strings.any? { |string| !string.is_a?(String) }

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
  end
end