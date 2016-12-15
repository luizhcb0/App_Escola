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
    context 'when valid' do
      before(:each) { post :create, params: { user: attributes_for(:user) } }
      let(:professor) { assigns(:professor) }

      it "should redirect to professors_path" do
        expect(response).to redirect_to(professors_path)
      end

      it "should save the professor" do
        expect(professor).to_not be nil
        expect(professor).to be_persisted
      end

      it "should save a valid professor user" do
        expect(professor.user).to_not be nil
        expect(professor.user).to be_persisted
        expect(professor.user.name).to eq "User"
        expect(professor.user.email).to eq "email@gmail.com"
        expect(professor.user.authenticate("12345678")).to be professor.user
        expect(professor.user.role).to eq 1
      end
    end

    context 'when invalid' do
      xit "should fail" do
      end
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
    context 'when valid' do
      before(:each) do
        professor = create(:professor)
        patch :update, params: {
          user: attributes_for(:user, name: "User2", email: "test@gmail.com",
            password: "54321", password_confirmation: "54321", role: 2),
          id: professor.id }
      end
      let(:professor) { assigns(:professor) }

      it "should be success" do
        expect(response).to redirect_to(professors_path(professor.id))
      end

      it "should update user attributes" do
        expect(professor.user.name).to eq "User2"
        expect(professor.user.email).to eq "test@gmail.com"
        expect(professor.user.password).to eq "54321"
        expect(professor.user.role).to eq 2
      end
    end

    context 'when invalid' do
      xit "should fail" do
      end
    end
  end

  describe "DELETE #destroy" do
    context 'when requested professor exists' do
      let(:professor) { test_professors[rand 2] }
      before(:each) { delete :destroy, params: { id: professor.id } }

      it "should redirect to professors_path" do
        expect(response).to redirect_to(professors_path)
      end

      it "should have deleted the professor from the DB" do
        expect(Professor.all).not_to include professor
        expect { professor.reload }.to raise_exception ActiveRecord::RecordNotFound
      end

      xit "should delete dependents from DB" do
      end
    end

    context 'when requested professor does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
