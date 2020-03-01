class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.belongs_to :flight
    end
  end
end
