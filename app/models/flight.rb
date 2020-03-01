class Flight < ApplicationRecord
  validates :from_airport, :to_airport, :start_datetime, :end_datetime, presence: true
  validate :end_after_start

  private
    def end_after_start
      return if end_datetime.nil? || start_datetime.nil?
      
      if end_datetime <= start_datetime
        errors.add(:end_datetime, 'end datetime must be after start datetime')
      end
    end
end
