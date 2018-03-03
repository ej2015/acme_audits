class AuditCreationService 

  attr_reader :file

  def initialize(file)
    file_path = file.path
    @file = SmarterCSV.process(file_path, options)
  end

  def call
    ImportCsvWorker.perform_async(@file)
    true
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
