class Api::V1::FlightsController < ActionController::API
  def find
    render json: {}.to_json, status: :ok
  end
end