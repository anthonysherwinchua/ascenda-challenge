# frozen_string_literal: true

module Orm
  module Parsers
    module Zipcode
      def zipcode_from(address)
        return unless address

        zipcode_regex = /\b\d{6}(?:-\d{4})?\b/
        match = address.match(zipcode_regex)
        match[0] if match
      end
    end
  end
end
