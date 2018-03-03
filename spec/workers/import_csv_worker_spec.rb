require 'rails_helper'
RSpec.describe ImportCsvWorker, type: :worker do

  it 'creates one worker' do
    file = double("Array")
    expect { ImportCsvWorker.perform_async(file) }.to change(ImportCsvWorker.jobs, :size).by 1
  end
 
  it 'creates same number of ImportLogWorker as chunks' do
    chunks = [[], []]
    expect(ImportLogWorker).to receive(:perform_async).with([]).twice
    ImportCsvWorker.new.perform(chunks)
  end


end
