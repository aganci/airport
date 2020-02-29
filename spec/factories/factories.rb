FactoryBot.define do
  factory :flight do
    start_datetime { 1.month.from_now }
    end_datetime { start_datetime + 3.hours }
    from_airport { 'MXP' }
    to_airport { 'DUB' }
  end
end