require 'rails_helper'
RSpec.describe TransformChunk do

    before :all do
      csv_directory = Rails.root.join("spec", "support", "sample_audit_log.csv")
      options = { chunk_size: 2 }
      chunks = SmarterCSV.process(csv_directory, options)
      @transformer = TransformChunk.new(chunks[0])
    end

  describe "#call" do
    it "gives correct headers and object types" do
      expect(@transformer.call).to eq [
                                        {:auditable_id=>1, :auditable_type=>"customer_order", :timestamp=>1520045959, :event=>"{\"customer_name\":\"Sam\",\"customer_address\":\"Gecko St.\",\"status\":\"unpaid\"}"}, 
                                        {:auditable_id=>2, :auditable_type=>"customer_order", :timestamp=>1520045959, :event=>"{\"customer_name\":\"Sam\",\"customer_address\":\"Gecko St.\",\"status\":\"unpaid\"}"}
                                      ] 
    end
  end

end
