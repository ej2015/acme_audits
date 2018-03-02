require 'rails_helper'

RSpec.describe "audits/show", type: :view do
  before(:each) do
    @audit = assign(:audit, Audit.create!(
      :auditable_id => 2,
      :auditable_type => 3,
      :timestamp => "",
      :event => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
