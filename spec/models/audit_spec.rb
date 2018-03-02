require 'rails_helper'

RSpec.describe Audit, type: :model do

  let(:audit) { build :audit }

  it "is valid with auditable_id and auditable_type" do
    expect(audit).to be_valid
  end

  it "should have auditable_type" do
    audit.auditable_id = ""
    expect(audit).to_not be_valid
  end

  it "should have auditable_type" do
    audit.auditable_type = ""
    expect(audit).to_not be_valid
  end


end
