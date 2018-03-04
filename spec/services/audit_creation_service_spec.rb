require 'rails_helper'
RSpec.describe AuditCreationService do

  describe "#call" do
    it "calls ImportCsvWorker" do
      file = double
      allow(file).to receive(:path).and_return Rails.root.join("spec", "support", "sample_audit_log.csv")
      service = AuditCreationService.new(file)
      allow(service).to receive(:process_and_save_file)
      expect(ImportCsvWorker).to receive(:perform_async)
      AuditCreationService.new(file).call
    end
  end

  describe "#process_file" do
    it "preprocess file to alter header and make it legle for csv processing" do
      file = double
      allow(file).to receive(:path).and_return Rails.root.join("spec", "support", "sample_audit_log.csv")
      service = AuditCreationService.new(file)
      expect(service.process_file).to eq "auditable_id,auditable_type,timestamp,event\n1,Order,1484730554,\"{customer_name:Jack,customer_address:Trade St.,status:unpaid}\"\n2,Order,1484730623,\"{customer_name:Sam,customer_address:Gecko St.,status:unpaid}\"\n1,Product,1484731172,\"{name:Laptop,price:2100,stock_levels:29}\"\n1,Order,1484731481,\"{status:paid,ship_date:2017-01-18,shipping_provider:DHL}\"\n2,Product,1484731671,\"{name:Microphones,price:160,stock_levels:1500}\"\n1,Invoice,1484731920,\"{order_id:7,product_ids:[1,5,3],status:unpaid,total:2500}\"\n1,Invoice,1484732821,\"{status:paid}\"\n\n"
    end
  end

end
