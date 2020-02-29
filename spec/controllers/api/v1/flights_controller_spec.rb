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

      it 'should list flights' do
        get :find, format: :json

        expect(response).to be_successful
      end
    end
  end
end