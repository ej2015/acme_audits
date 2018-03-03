require 'rails_helper'
RSpec.describe ImportLogWorker, type: :worker do

  it 'creates one worker' do
    chunk = double("Array")
    expect { ImportLogWorker.perform_async(chunk) }.to change(ImportLogWorker.jobs, :size).by 1
  end

end
