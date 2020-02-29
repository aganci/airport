require 'rails_helper'

RSpec.describe Api::V1::FlightsController do
  describe 'GET api/v1/flights' do
    it 'should list flights' do
      get :find, format: :json

      expect(response).to be_successful
    end
  end
end