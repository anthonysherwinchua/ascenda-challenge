# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    zipcode { Faker::Address.zip_code }
  end
end
