class City < ApplicationRecord
  has_many :users
  has_many :accomodations

  validates :city_name,
    presence: true
  validates :zip_code,
    presence: true,
    uniqueness: true,
    format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "please enter a valid french zip code" }

end
