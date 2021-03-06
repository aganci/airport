class FindFlight
  prepend SimpleCommand

  def initialize(from_airport, to_airport, date)
    @from_airport = from_airport
    @to_airport = to_airport
    @date = date
  end

  def call
    if @from_airport.blank?
      errors.add(:message, 'from_airport cannot be blank')
      return
    end

    if @to_airport.blank?
      errors.add(:message, 'to_airport cannot be blank')
      return
    end

    if @date.nil?
      errors.add(:message, 'date cannot be blank')
      return
    end

    Flight
      .where(from_airport: @from_airport)
      .where(to_airport: @to_airport)
      .where('start_datetime >= ?', @date.to_date)
      .where('start_datetime < ?', @date.to_date + 1.day)
  end
end
