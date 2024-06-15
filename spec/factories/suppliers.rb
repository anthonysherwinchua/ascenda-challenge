# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    name { Faker::FunnyName.two_word_name }
    url { Faker::Internet.url }
  end
end
