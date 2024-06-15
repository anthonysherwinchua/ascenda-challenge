# frozen_string_literal: true

FactoryBot.define do
  factory :amenity do
    name { Faker::Appliance.equipment }
    category { Faker::Lorem.word }
  end
end
