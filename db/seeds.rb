# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  # Create Thermostat
  10.times do
    Thermostat.create!(
      household_token: 'HSE_' + Faker::Alphanumeric.alphanumeric(number: 20),
      location: Faker::Address.full_address
    )
  end

  # # Create Readings for the thermostats
  thermostats = Thermostat.all
  thermostats.each do |thermostat|
    number = Reading.sequence_number
    temperature = Faker::Number.within(range: -25..45)
    humidity = Faker::Number.within(range: 1..100)
    battery_charge = Faker::Number.within(range: 1..100)

    reading = thermostat.readings.build(
      number: number,
      temperature: temperature,
      humidity: humidity,
      battery_charge: battery_charge
    )

    reading.save!
  end
end
