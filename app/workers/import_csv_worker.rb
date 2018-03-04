class ImportCsvWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(directory)
    chunks = SmarterCSV.process(directory, options)

    #transformed_chunks = TransformChunk.new(file_chunks).call    
    chunks.each do |chunk|
      ImportLogWorker.perform_async(chunk)
    end
  end

  ###private
 
  def options 
    { chunk_size: 700,
     #this option unfortunately doesn't work
     # header_transformations: [
     #   key_mapping: { 
     #     object_id:        :auditable_id, 
     #     object_type:      :auditable_type, 
     #     object_changes:   :nil 
     #   }
     # ]
    }
  end
end
