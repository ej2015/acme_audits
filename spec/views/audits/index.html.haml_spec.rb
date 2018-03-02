require 'rails_helper'

RSpec.describe "audits/index", type: :view do
  before(:each) do
    assign(:audits, [
      Audit.create!(
        :auditable_id => 2,
        :auditable_type => 3,
        :timestamp => "",
        :event => ""
      ),
      Audit.create!(
        :auditable_id => 2,
        :auditable_type => 3,
        :timestamp => "",
        :event => ""
      )
    ])
  end

  it "renders a list of audits" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
