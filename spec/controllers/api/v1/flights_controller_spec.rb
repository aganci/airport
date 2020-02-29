require 'rails_helper'

RSpec.describe Api::V1::FlightsController do
  describe 'GET api/v1/flights' do
    context 'not authenticated' do
      it 'should list flights' do
        get :find, format: :json

        expect(response.status).to be(401)
      end
    end

    context 'authenticated' do
      before do
        api_sign_in
      end

      let(:flight) { build(:flight, 
        from_airport: 'MXP', to_airport: 'DUB', 
        start_datetime: DateTime.new(2020, 2, 1, 10, 30),
        end_datetime: DateTime.new(2020, 2, 1, 18, 30))
      }

      let(:find_params) {
        {
          find_params: {
            from_airport: 'MXP',
            to_airport: 'DUB',
            date: '2020-02-01'
          }
        }
      }

      it 'should list found flights' do
        command = FakeCommand.new [flight]
        allow(FindFlight).to receive(:call).with('MXP', 'DUB', Date.new(2020, 2, 1)).and_return(command)

        get :find, params: find_params, format: :json

        parsed_body = JSON.parse(response.body)
        
        expect(parsed_body.size).to eq(1)
        expect(parsed_body[0]['from_airport']).to eq('MXP')
        expect(parsed_body[0]['to_airport']).to eq('DUB')
        expect(parsed_body[0]['start_datetime']).to eq('2020-02-01T10:30:00.000Z')
        expect(parsed_body[0]['end_datetime']).to eq('2020-02-01T18:30:00.000Z')
      end
    end
  end
end