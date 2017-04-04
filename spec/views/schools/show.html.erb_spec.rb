require 'rails_helper'

RSpec.describe "schools/show.html.erb", type: :view do
  before(:each) {
    assign(:school, build(:school, id:2))
    render
  }

  it "should show school atributes" do
    expect(rendered).to match(/User/) # school name
  end

  it "should show school principal user attributes" do
    expect(rendered).to match(/User/)         # user name
  end

  it "should render user_show partial" do
    expect(view).to render_template(:partial => "_user_show")
  end
end
