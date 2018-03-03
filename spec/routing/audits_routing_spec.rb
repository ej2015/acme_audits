require "rails_helper"

RSpec.describe AuditsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/audits").to route_to("audits#index")
    end

    it "routes to #new" do
      expect(:get => "/audits/new").to route_to("audits#new")
    end

    it "routes to #create" do
      expect(:post => "/audits").to route_to("audits#create")
    end

  end
end
