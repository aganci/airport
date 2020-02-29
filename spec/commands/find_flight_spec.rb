require 'rails_helper'

RSpec.describe FindFlight do
  subject(:context) { described_class.call(from_airport, to_airport, date) }

  describe '.call' do
    context 'when the context is successful' do
      let(:from_airport) { 'MXP' }
      let(:to_airport) { 'DUB' }
      let(:date) { Date.new(2020, 2, 1) }
      
      it 'should return all date with same from and to airport in the same day' do
        flight = create(:flight, from_airport: from_airport, to_airport: to_airport, start_datetime: DateTime.new(2020, 2, 1, 15, 30))

        expect(context.result.first).to eq(flight)
      end
    end
  end
end