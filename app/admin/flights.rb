ActiveAdmin.register Flight do
  permit_params :from_airport, :to_airport, :start_datetime, :end_datetime, :capacity
end
