class Api::V1::FlightsController < Api::ApplicationController
  def find
    render json: {}.to_json, status: :ok
  end
end