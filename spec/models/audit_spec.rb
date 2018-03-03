require 'rails_helper'

RSpec.describe Audit, type: :model do

  let(:audit) { build :audit }
  let(:audit_product) { create(:audit, auditable_type: "product", auditable_id: 1, timestamp: 1520061786) }
  let(:audit_order) { create(:audit, auditable_type: "customer_order", auditable_id: 2, timestamp: 1520061789) }

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
 
  describe "#with_auditable_type" do
    it "should return correct type" do
      expect(Audit.with_auditable_type("product")).to contain_exactly audit_product
    end
  end

  describe "#with_auditable_id" do
    it "should return correct id" do
      expect(Audit.with_auditable_id(2)).to contain_exactly audit_order
    end
  end

  describe "#with_timestamp" do
    it "should return timestamp" do
      expect(Audit.with_timestamp(1520061789)).to contain_exactly audit_order
    end
  end

end
