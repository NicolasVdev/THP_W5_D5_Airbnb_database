class Reservation < ApplicationRecord
  belongs_to :guest, class_name: "User"
  belongs_to :accomodation
  
  validates :start_date,
    presence: true
  validates :end_date,
    presence: true
  validate :start_must_be_before_end_time
  validate :no_overlapping_reservations


  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end time") unless
        start_date < end_date
  end 


  def duration
    (end_date - start_date).to_i
  end

# Partie à revoir
  def no_overlapping_reservations
    if accomodation.reservations.where.not(id: id).where("start_date < ? AND end_date > ?", end_date, start_date).any?
      errors.add(:base, "This accomodation is already reserved for the selected dates.")
    end
  end

end
