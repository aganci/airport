class FindFlight
  prepend SimpleCommand

  def initialize(from_airport, to_airport, date)
    @from_airport = from_airport
    @to_airport = to_airport
    @date = date
  end

  def call
    Flight.where(from_airport: @from_airport)
  end
end
