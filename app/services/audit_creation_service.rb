class AuditCreationService 

  attr_reader :file

  def initialize(file_path)
    @file = SmarterCSV.process(file_path, options)
  end

  def call
    create_logs
  end
 
  ###private

  def create_logs
    @file.each do |chunk|
      create_log chunk 
    end
  end

  def create_log(chunk)
    ImportLogWorker.perform_async(chunk)
  end
 
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
