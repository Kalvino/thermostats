class ReadingCreator < ApplicationService
  def initialize(reading_params_hash)
    @reading_params = reading_params_hash
    @number = reading_params_hash[:number]
  end

  def call
    create_reading
  end

  def create_reading
    reading = Reading.new(@reading_params)
    
    redis_key = "reading_" + @number.to_s
    $redis_db.set(redis_key, @reading_params)
    ReadingWorker.perform_in(1.minutes, @reading_params)
  end
end