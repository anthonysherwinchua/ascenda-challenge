FactoryBot.define do
  factory :amenity do
    name { Faker::Appliance.equipment }
    category { Faker::Lorem.word }
  end
end
