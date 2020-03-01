class BookFlight
  prepend SimpleCommand

  def initialize(flight_id, passenger_params)
    @flight_id = flight_id
    @passenger_params = passenger_params
  end

  def call
    Passenger.new(@passenger_params.merge(flight_id: @flight_id)).tap do |p|
      p.save!
    end
  end
end