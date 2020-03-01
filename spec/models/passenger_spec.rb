require 'rails_helper'

RSpec.describe Passenger, type: :model do
  let(:passenger) { build(:passenger) }

  it "should have a flight" do
    passenger.flight = nil

    expect(passenger).to_not be_valid
  end
end
