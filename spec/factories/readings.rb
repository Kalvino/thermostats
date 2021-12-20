FactoryBot.define do
    factory :reading do
      thermostat
      number { Reading.sequence_number }
      temperature { Faker::Number.within(range: -25..45) }
      humidity { Faker::Number.within(range: 1..100) }
      battery_charge { Faker::Number.within(range: 1..100) }
    end
  end
