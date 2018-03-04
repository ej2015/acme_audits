require 'rails_helper'
RSpec.describe ImportCsvWorker, type: :worker do

  it 'creates one worker' do
    file = double("Array")
    expect { ImportCsvWorker.perform_async(file) }.to change(ImportCsvWorker.jobs, :size).by 1
  end

  it 'calls SmarterCSV' do
    directory = double
    expect(SmarterCSV).to receive(:process).and_return [[]]
    ImportCsvWorker.new.perform(directory)
  end
 
 
  it 'creates same number of ImportLogWorker as chunks' do
    directory = double
    allow(SmarterCSV).to receive(:process).and_return([[],[]])
    expect(ImportLogWorker).to receive(:perform_async).with([]).twice
    ImportCsvWorker.new.perform(directory)
  end

end
