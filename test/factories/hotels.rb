FactoryBot.define do
  factory :hotel do
    location { create(:location) }

    hotel_id { Faker::Alphanumeric.alphanumeric(number: 4) }
    destination_id { Faker::Number.number(digits: 4) }
    name { Faker::Restaurant.name }
  end
end
