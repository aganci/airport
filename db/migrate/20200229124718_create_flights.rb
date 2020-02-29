class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.string :from_airport
      t.string :to_airport
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :capacity

      t.timestamps
    end
  end
end
