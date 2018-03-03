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
    transformed_chunk = chunk.map { |record| record.transform_keys(&header_key_transformation) }.map { |record| record.map(&value_transformation).to_h }
    Audit.import transformed_chunk
  end
 
  def options 
    { chunk_size: 2000,
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

  def header_key_transformation
    Proc.new do |key|
      case key
      when :object_id
        :auditable_id
      when :object_type
        :auditable_type
      when :object_changes
        :event
      else
        key
      end
    end
  end

  def value_transformation
    Proc.new do |k,v|
      if k == :auditable_type
        if v == "Order"
          [k, "customer_order"]
        else
          [k, v.downcase]
        end
        
      else
        [k, v]
      end
    end
  end
end 
