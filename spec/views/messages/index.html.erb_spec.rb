require 'rails_helper'

RSpec.describe "messages/index.html.erb", type: :view do
  before(:each) {
    create(:message)
    assign(:messages, Message.all)
    render
  }

  it "should display all message professors" do
    expect(rendered).to match(/Mensagem/)
  end
end
