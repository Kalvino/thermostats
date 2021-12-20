FactoryBot.define do
    factory :thermostat do
      household_token { 'HSE_' + Faker::Alphanumeric.alphanumeric(number: 20) }
      location { Faker::Address.full_address }
    end
  end
