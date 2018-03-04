require 'rails_helper'
RSpec.describe TransformChunk do

  describe "#call" do
    it "changes order to customer_order and downcase auditable_type values" do
      data = [{ "auditable_type" => "Order", "event" => "Order changed" }, { "auditable_type" => "Invoince", "event" => "Order changed" }]
      expect(TransformChunk.new(data).call).to eq [{ "auditable_type" => "customer_order", "event" => "Order changed" }, { "auditable_type" => "invoince", "event" => "Order changed" }]

    end
  end

end
