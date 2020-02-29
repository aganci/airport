class Flight < ApplicationRecord
  validates :from_airport, presence: true
end
