require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:test_schools) { 2.times.map { create(:school) } }

  describe "GET #index" do
    before(:each) { get :index }

    it "should be success" do
      expect(response).to be_success
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should load all schools" do
      expect(assigns(:schools)).to match_array test_schools
    end
  end

  describe "GET #show" do
    context 'when requested school exists' do
      let(:school) { test_schools[rand 2] }
      before(:each) { get :show, params: { id: school.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load school" do
        expect(assigns(:school)).to eq school
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
      expect(assigns(:school)).to_not eq nil
    end
  end


  describe "POST #create" do

    context 'when valid' do
      before(:each) do post :create, params: {
        school: attributes_for(:school),
        person: attributes_for(:person), login: attributes_for(:login) }
      end
      let(:school) { assigns(:school) }

      it "should redirect to schools_path" do
        expect(response).to redirect_to(schools_path)
      end

      it "should save school" do
        expect(school).to be_persisted
      end

      it "should save a professor(principal)" do
        expect(school.professor).to_not be nil
        expect(school.professor).to be_persisted
      end

      it "should save a valid professor(principal) person" do
        expect(school.professor.person).to_not be nil
        expect(school.professor.person).to be_persisted
        expect(school.professor.person.name).to eq "Diretora"
      end

      it "should save a valid professor(principal) login" do
        expect(school.professor.login).to_not be nil
        expect(school.professor.login).to be_persisted
        expect(school.professor.login.username).to eq "Vira Ventos"
        expect(school.professor.login.password).to eq "12345"
        expect(school.professor.login.role).to eq 1
      end
    end

    context 'when invalid' do
      xit "should fail" do
      end
    end
  end

  describe "GET #edit" do
    let(:school) { test_schools[rand 2] }
    before(:each) { get :edit, params: { id: school.id } }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the school" do
      expect(assigns(:school)).to eq school
    end
  end

  describe "PATCH #update" do

    context 'when valid' do
      before(:each) do
        school = create(:school, :stubed)
        patch :update, params: {
          school: attributes_for(:school, name: "Teste2"),
          person: attributes_for(:person, name: "outro"),
          login: attributes_for(:login, username: "vv", password: "54321", role: 2),
          id: school.id }
      end
      let(:school) { assigns(:school) }

      it "should be success" do
        expect(response).to redirect_to(schools_path(school.id))
      end

      it "should update school attributes" do
        expect(school.name).to eq "Teste2"
      end

      it "should update person attributes" do
        expect(school.professor.person.name).to eq "outro"
      end

      it "should update login attributes" do
        expect(school.professor.login.username).to eq "vv"
        expect(school.professor.login.password).to eq "54321"
        expect(school.professor.login.role).to eq 2
      end
    end

    context 'when invalid' do
      xit "should fail" do
      end
    end
  end

  describe "DELETE #destroy" do
    context 'when requested school exists' do
      let(:school) { test_schools[rand 2] }
      before(:each) { delete :destroy, params: { id: school.id } }

      it "should redirect to schools_path" do
        expect(response).to redirect_to(schools_path)
      end

      it "should have deleted the school from the DB" do
        expect(School.all).not_to include school
        expect { school.reload }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context 'when requested school does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
