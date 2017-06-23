require 'rails_helper'

RSpec.describe Api::V1::ProfessorsController, type: :controller do
  let!(:test_professors) { 2.times.map { create(:professor) } }
  before(:each) { request.headers['Accept'] = "application/vnd.app_escola.v1" }
  
  describe "GET #index" do
    before(:each) { get :index, format: :json }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load all professors" do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq 2
    end
  end
  
  describe "GET #show" do
    context "when requested professor exists" do
      let(:professor) { test_professors[rand 2] }
      before(:each) { get :show, params: { id: professor.id, format: :json } }
      
      it "should return the correct information" do
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:name]).to eq professor.name
        expect(parsed_response[:id]).to eq professor.id
      end
      
      it "should be success" do
        expect(response).to be_success
      end
    end
    
    context "when requested professor does not exist" do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1, format: :json } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
    
  end
end