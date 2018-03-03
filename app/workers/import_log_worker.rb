class ImportLogWorker
  include Sidekiq::Worker
  sidekiq_options retry: false 

  def perform(chunk)
    Audit.import chunk
  end

end
