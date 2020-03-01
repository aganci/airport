class Passenger < ApplicationRecord
  validates :name, :address, :city, :country, presence: true
  belongs_to :flight
end
