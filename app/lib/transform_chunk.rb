class TransformChunk
  
  def initialize(chunk)
    @chunk = chunk
  end

  def call
    @chunk.map { |record| record.transform_keys(&header_key_transformation) }.map { |record| record.map(&value_transformation).to_h }
  end

  ##private

  def header_key_transformation
    Proc.new do |key|
      case key.to_s
      when "object_id"
        :auditable_id
      when "object_type"
        :auditable_type
      when "object_changes"
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
