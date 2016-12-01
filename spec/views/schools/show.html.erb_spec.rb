require 'rails_helper'

RSpec.describe "schools/show.html.erb", type: :view do
  before(:each) {
    assign(:school, build(:school, id:2))
    render
  }

  it "should show school atributes" do
    expect(rendered).to match(/Escola Teste/) # school name
    expect(rendered).to match(/Diretora/)     # person name
    expect(rendered).to match(/Vira Ventos/)  # login username
  end

end