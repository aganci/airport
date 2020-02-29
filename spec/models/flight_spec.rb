require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:start_datetime) { 1.month.from_now }
  let(:end_datetime) { start_datetime + 3.hours }
  let(:flight) { described_class.new(from_airport: 'MXP', to_airport: 'DUB', start_datetime: start_datetime, end_datetime: end_datetime) }

  it "should validate from_airport" do
    flight.from_airport = nil

    expect(flight).to_not be_valid
  end
end
