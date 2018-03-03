class ImportLogWorker
  include Sidekiq::Worker
  sidekiq_options retry: false 

  def perform(chunk)
    transformed_chunk = TransformChunk.new(chunk).call    
    Audit.import transformed_chunk
  end

end
