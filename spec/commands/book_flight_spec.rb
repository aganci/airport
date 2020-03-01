require 'rails_helper'

RSpec.describe BookFlight do
  let(:flight) { create(:flight) }
  subject(:context) { described_class.call(flight.id, passenger_params) }

  describe '.call' do
    context 'when valid book params' do
      let(:passenger_params) {
        {
          name: 'Mario Rossi',
          address: 'Via Milano, 6',
          city: 'Milano',
          country: 'Italia'
        }
      }
      
      it "should create passenger" do
        expect { subject }.to change{ Passenger.count }.by(1)
      end
    end
  end
end
