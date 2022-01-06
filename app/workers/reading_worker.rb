class ReadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(reading_params)
    Reading.create!(reading_params)
  end
end
