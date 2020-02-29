class Api::V1::FlightsController < Api::ApplicationController
  def find
    command = FindFlight.call(find_params[:from_airport], find_params[:to_airport], find_params[:date].to_date)
    
    render json: command.result.to_json, status: :ok
  end

  private
    def find_params
      params.require(:find_params).permit(:from_airport, :to_airport, :date)
    end
end