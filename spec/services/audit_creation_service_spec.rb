require 'rails_helper'
RSpec.describe AuditCreationService do

  it 'calls SmarterCSV' do
    file = double
    allow(file).to receive :path
    expect(SmarterCSV).to receive(:process)
    AuditCreationService.new(file)
  end
 
  describe "#call" do
    it "calls ImportCsvWorker" do
      file = double
      allow(file).to receive :path
      allow(SmarterCSV).to receive(:process).and_return [[]]
      service = instance_double("AuditCreationService")
      expect(ImportCsvWorker).to receive(:perform_async)
      AuditCreationService.new(file).call
    end
  end

end
