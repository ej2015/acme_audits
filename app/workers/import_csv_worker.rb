class ImportCsvWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(file_chunks)
    transformed_chunks = TransformChunk.new(file_chunks).call    
    transformed_chunks.each do |chunk|
      ImportLogWorker.perform_async(chunk)
    end
  end
end
