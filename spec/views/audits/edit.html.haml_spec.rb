require 'rails_helper'

RSpec.describe "audits/edit", type: :view do
  before(:each) do
    @audit = assign(:audit, Audit.create!(
      :auditable_id => 1,
      :auditable_type => 1,
      :timestamp => "",
      :event => ""
    ))
  end

  it "renders the edit audit form" do
    render

    assert_select "form[action=?][method=?]", audit_path(@audit), "post" do

      assert_select "input[name=?]", "audit[auditable_id]"

      assert_select "input[name=?]", "audit[auditable_type]"

      assert_select "input[name=?]", "audit[timestamp]"

      assert_select "input[name=?]", "audit[event]"
    end
  end
end
