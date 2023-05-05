# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Détruire ta base actuelle
User.destroy_all
City.destroy_all
Accomodation.destroy_all
Reservation.destroy_all

# Créer 20 utilisateurs
20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    # phone_number: "+33 #{rand(1..9)} #{rand(10..99)} #{rand(10..99)} #{rand(10..99)} #{rand(10..99)}",
    description: Faker::Lorem.paragraph
  )
end

# Créer 10 villes en France
10.times do
  City.create!(
    city_name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end


# Créer 50 listings/Accommodations
50.times do
  Accomodation.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    available_beds: Faker::Number.between(from: 1, to: 5),
    price: Faker::Number.between(from: 20, to: 200),
    description: Faker::Lorem.paragraph_by_chars(number: 140, supplemental: false),
    has_wifi: Faker::Boolean.boolean,
    welcome_message: Faker::Lorem.paragraph,
    city: City.order('RANDOM()').first,
    user: User.order('RANDOM()').first
  )
end

# Pour chaque listing
#créer 5 réservations dans le passé
5.times do
  start_date = Faker::Date.between(from: 1.year.ago, to: Date.today)
  end_date = Faker::Date.between(from: start_date + 1.day, to: Date.today)

  Reservation.create!(
    guest: User.order('RANDOM()').first,
    accomodation: Accomodation.order('RANDOM()').first,
    start_date: start_date,
    end_date: end_date
  )
end

#créer 5 réservations dans le futur
5.times do
  start_date = Faker::Date.between(from: Date.today, to: 3.months.from_now)
  end_date = Faker::Date.between(from: start_date + 1.day, to: start_date + 10.days)

  Reservation.create!(
    guest: User.order('RANDOM()').first,
    accomodation: Accomodation.order('RANDOM()').first,
    start_date: start_date,
    end_date: end_date
  )
end

