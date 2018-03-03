require 'rails_helper'



RSpec.describe AuditsController, type: :controller do

  let(:valid_attributes) {
    { 
      auditable_id: 1,
      auditable_type: "invoice",
      timestamp: 1519958349,
      event: {"customer_name":"Sam","customer_address":"Gecko St.","status":"unpaid"}

    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AuditsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      audit = Audit.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
      it "creates a new Audit" do
        directory = double
        params = { audit: { file: directory } }
        allow(AuditCreationService).to receive_message_chain(:new, :call).and_return true
        post :create, params: params, session: valid_session
      end
  end

end
