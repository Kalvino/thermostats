class ReadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(number, thermostat_id, temperature, humidity, battery_charge)
    reading = Reading.new(thermostat_id: thermostat_id,
                               number: number,
                          temperature: temperature,
                             humidity: humidity,
                      battery_charge: battery_charge)
    reading.save!
  end
end
