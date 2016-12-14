require 'rails_helper'

RSpec.describe "professors/show.html.erb", type: :view do
  before(:each) {
    assign(:professor, build(:professor, id:2))
    render
  }

  it "should show school atributes" do
    expect(rendered).to match(/Diretora/)     # person name
    expect(rendered).to match(/User/)         # user name
  end
end
