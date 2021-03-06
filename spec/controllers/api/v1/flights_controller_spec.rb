require 'rails_helper'

RSpec.describe Api::V1::FlightsController do
  describe 'GET api/v1/flights' do
    context 'not authenticated' do
      it 'should not permit unauthenticated requests' do
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

      it 'should not show all model fields' do
        command = FakeCommand.new [flight]
        allow(FindFlight).to receive(:call).with('MXP', 'DUB', Date.new(2020, 2, 1)).and_return(command)

        get :find, params: find_params, format: :json

        parsed_body = JSON.parse(response.body)
        
        expect(parsed_body[0].keys).to eq(["id", "from_airport", "to_airport", "start_datetime", "end_datetime"])
      end

      it "should render errors given invalid params" do
        command = FakeCommand.new
        command.set_error(:message, 'an error')

        allow(FindFlight).to receive(:call).and_return(command)

        get :find, params: find_params, format: :json

        expect(response.status).to eq(400)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']['message']).to eq('an error')
      end
    end
  end

  describe 'POST api/v1/flights/:id/book' do
    context 'not authenticated' do
      it 'should not permit unauthenticated requests' do
        post :book, params: { id: 1 }, format: :json

        expect(response.status).to be(401)
      end
    end

    context 'authenticated' do
      let(:passenger_params) {
        {
          name: 'Mario Rossi',
          address: 'Via Milano, 6',
          city: 'Milano',
          country: 'Italia'
        }
      }

      before do
        api_sign_in
      end

      it 'should use book command to book a flight' do
        command = FakeCommand.new(Passenger.new(id: 123))
        expect(BookFlight).to receive(:call).with(1, passenger_params).and_return(command)

        post :book, params: { id: 1, passenger: passenger_params }, format: :json

        expect(response.status).to be(200)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['passender_id']).to eq(123)
      end

      it "should render errors given invalid params" do
        command = FakeCommand.new
        command.set_error(:message, 'an error')

        allow(BookFlight).to receive(:call).and_return(command)

        post :book, params: { id: 1, passenger: passenger_params }, format: :json

        expect(response.status).to eq(400)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']['message']).to eq('an error')
      end
      
    end    
  end
end