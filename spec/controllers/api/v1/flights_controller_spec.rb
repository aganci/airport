require 'rails_helper'

RSpec.describe Api::V1::FlightsController do
  describe 'GET api/v1/flights' do
    before do
      user = create(:user)
      command = AuthenticateUser.new(user.email, user.password).call
      request.headers.merge!({'Authorization': "Bearer #{command.result}"})
    end

    it 'should list flights' do
      get :find, format: :json

      expect(response).to be_successful
    end
  end
end