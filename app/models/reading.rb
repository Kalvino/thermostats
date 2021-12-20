class Reading < ApplicationRecord
  # many to one association with thermostat
  belongs_to :thermostat

  # delete redis record after creation
  after_create :clear_redis_data  

  # validations
  validates :number, :temperature, :humidity, :battery_charge, presence: true
  validates :number, numericality: { only_integer: true }, uniqueness: true
  validates :temperature, :humidity, :battery_charge, numericality: { only_float: true }

  # next sequence number
  def self.sequence_number
    Reading.connection.select_value("Select nextval('readings_id_seq')")
  end 

  # delete record from redis database
  def clear_redis_data
    # $redis_db.del(self.number)
    key = "reading_" + self.number.to_s
    $redis_db.del(key)
  end

  def self.generate_new
    thermostats_count = Thermostat.count
    thermostat_id = Faker::Number.within(range: 1..thermostats_count)
    
    number = Reading.sequence_number
    temperature = Faker::Number.within(range: -25..45)
    humidity = Faker::Number.within(range: 1..100)
    battery_charge = Faker::Number.within(range: 1..100)

    thermostat = Thermostat.find(thermostat_id)

    # create reading with values
    thermostat.readings.create!(
      number: number,
      temperature: temperature,
      humidity: humidity,
      battery_charge: battery_charge
    )
  end 
end
