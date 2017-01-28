require 'rails_helper'

RSpec.describe "messages/show.html.erb", type: :view do
  before(:each) {
    # needs to be create because of the timestamp
    assign(:message, create(:message, students: [create(:student, users: [create(:user)])]))
    render
  }

  it "should show message attributes" do
    expect(rendered).to match(/User/)     # professor name
    expect(rendered).to match(/Mensagem/)     # message text
  end
end
