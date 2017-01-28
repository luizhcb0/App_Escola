require 'rails_helper'

RSpec.describe "activities/index.html.erb", type: :view do
  before(:each) {
    create(:activity)
    assign(:activities, Activity.all)
    render
  }

  it "should display all activity professors" do
    expect(rendered).to match(/Atividade/)
  end
end
