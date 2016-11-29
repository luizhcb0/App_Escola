require 'rails_helper'

RSpec.describe ProfessorsController, type: :controller do
  let(:test_professors) { 2.times.map { create(:professor) } }

  describe "GET #index" do
    before(:each) { get :index }

    it "should be success" do
      expect(response).to be_success
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should load all schools" do
      expect(assigns(:professors)).to match_array test_professors
    end
  end

  describe "GET #show" do
    xit "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    xit "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    xit "returns http success" do
      patch :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    xit "returns http success" do
      delete :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
