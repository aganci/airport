require 'rails_helper'

RSpec.describe BookFlight do
  let(:flight) { create(:flight) }
  subject(:context) { described_class.call(flight.id, passenger_params) }

  describe '.call' do
    let(:name) { 'Mario Rossi' }
    let(:passenger_params) {
      {
        name: name,
        address: 'Via Milano, 6',
        city: 'Milano',
        country: 'Italia'
      }
    }

    context 'when valid passenger_params' do
      it "should create passenger" do
        expect { subject }.to change{ Passenger.count }.by(1)
      end
    end

    context 'when invalid passenger_params' do
      let(:flight) { Flight.new(id: 1234) }
      
      describe 'flight not existent' do
        it "fails" do
          expect(context).to be_failure
        end
      end

      describe 'name not specified' do
        let(:name) {''}
        it "fails" do
          expect(context).to be_failure
        end
      end
    end
  end
end
