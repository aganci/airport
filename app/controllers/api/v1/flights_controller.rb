class Api::V1::FlightsController < Api::ApplicationController
  def find
    command = FindFlight.call(find_params[:from_airport], find_params[:to_airport], find_params[:date].to_date)
    
    if command.success?    
      render json: command.result.to_json(only: [:id, :from_airport, :to_airport, :start_datetime, :end_datetime]), status: :ok
    else
      render json: {error: command.errors}.to_json, status: :bad_request
    end
  end

  def book
    command = BookFlight.call(params[:id].to_i, passenger_params.to_hash.symbolize_keys)
    render json: {passender_id: command.result.id}.to_json, status: :ok
  end

  private
    def find_params
      params.require(:find_params).permit(:from_airport, :to_airport, :date)
    end

    def passenger_params
      params.require(:passenger).permit(:name, :address, :city, :country)
    end
end