FactoryBot.define do
  factory :passenger do
    association :flight, factory: :flight

    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end
end
