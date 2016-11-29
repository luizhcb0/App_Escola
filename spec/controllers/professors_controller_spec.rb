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
    context 'when requested school exists' do
      let(:professor) { test_professors[rand 2] }
      before(:each) { get :show, params: { id: professor.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load school" do
        expect(assigns(:professor)).to eq professor
      end
    end

    context 'when requested school does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

  describe "GET #new" do
    before(:each) { get :new }

    it "should be success" do
      expect(response).to be_success
    end

    it "should pass a school new" do
      expect(assigns(:professor)).to_not eq nil
    end
  end

  describe "POST #create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    let(:professor) { test_professors[rand 2] }
    before(:each) { get :edit, params: { id: professor.id } }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the school" do
      expect(assigns(:professor)).to eq professor
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
