require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:flight) { build(:flight) }

  it "should validate from_airport" do
    flight.from_airport = nil

    expect(flight).to_not be_valid
  end

  it "should validate to_airport" do
    flight.to_airport = nil

    expect(flight).to_not be_valid
  end

  it "should validate start_datetime" do
    flight.start_datetime = nil

    expect(flight).to_not be_valid
  end

  it "should validate end_datetime" do
    flight.end_datetime = nil

    expect(flight).to_not be_valid
  end

  it "should validate that start_datetime must be older than end_datetime" do
    flight.start_datetime = DateTime.new(2020, 2, 1, 10, 20)
    flight.end_datetime = DateTime.new(2020, 2, 1, 10, 10)

    expect(flight).to_not be_valid
  end
end
