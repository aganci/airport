class BookFlight
  prepend SimpleCommand

  def initialize(flight_id, passenger_params)
    @flight_id = flight_id
    @passenger_params = passenger_params
  end

  def call
    flight = Flight.find_by_id(@flight_id)
    if flight.nil?
      errors.add(:message, 'Flight not found')
      return
    end

    passenger = Passenger.new(@passenger_params.merge(flight: flight))
    if passenger.valid?
      passenger.save!
      passenger
    else
      errors.add(passenger.errors)
    end
  end
end