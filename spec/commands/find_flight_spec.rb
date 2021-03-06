require 'rails_helper'

RSpec.describe FindFlight do
  subject(:context) { described_class.call(from_airport, to_airport, date) }
  let(:from_airport) { 'MXP' }
  let(:to_airport) { 'DUB' }
  let(:date) { Date.new(2020, 2, 1) }

  describe '.call' do
    context 'when valid find params' do
      it 'should return all flights with same from and to airport in the same day' do
        flight = create(:flight, from_airport: from_airport, to_airport: to_airport, start_datetime: DateTime.new(2020, 2, 1, 15, 30))

        expect(context.result.first).to eq(flight)
      end

      it 'should return empty result given a different from_airport' do
        flight = create(:flight, from_airport: 'JFK', to_airport: to_airport, start_datetime: DateTime.new(2020, 2, 1, 15, 30))

        expect(context.result).to be_empty
      end

      it 'should return empty result given a different to_airport' do
        flight = create(:flight, from_airport: from_airport, to_airport: 'JFK', start_datetime: DateTime.new(2020, 2, 1, 15, 30))

        expect(context.result).to be_empty
      end

      it 'should return empty result given a different date' do
        flight = create(:flight, from_airport: from_airport, to_airport: to_airport, start_datetime: DateTime.new(2020, 2, 2, 15, 30))

        expect(context.result).to be_empty
      end
    end

    context 'when invalid find params' do
      describe 'invalid from_airport' do
        let(:from_airport) { '' }

        it 'fails' do
          expect(context).to be_failure
        end
      end

      describe 'invalid to_airport' do
        let(:to_airport) { '' }

        it 'fails' do
          expect(context).to be_failure
        end
      end

      describe 'invalid date' do
        let(:date) { nil }

        it 'fails' do
          expect(context).to be_failure
        end
      end

    end
  end
end