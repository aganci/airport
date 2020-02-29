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

      let(:flight) { build(:flight) }
      let(:find_params) {
        {
          find_params: {
            from_airport: 'MXP',
            to_airport: 'DUB',
            date: Date.new(2020, 2, 1)
          }
        }
      }

      it 'should list found flights' do
        command = FakeCommand.new [flight]
        allow(FindFlight).to receive(:call).and_return(command)

        get :find, params: find_params, format: :json

        parsed_body = JSON.parse(response.body)
        expect(parsed_body.size).to eq(1)
      end
    end
  end
end