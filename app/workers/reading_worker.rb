class ReadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(reading_params)
    reading  = Reading.new(reading_params)
    reading.save!
  end
end
