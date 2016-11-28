require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:test_schools) { 2.times.map { create(:school) } }

  describe "#index" do
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

  describe "#show" do
    context 'when requested school exists' do
      let(:school) { test_schools[rand 2] }
      before(:each) { get :show, id: school }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load school" do
        expect(assigns(:school)).to eq school
      end
    end

    context 'when requested school does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#new" do
    before(:each) { get :new }

    it "should be success" do
      expect(response).to be_success
    end

    it "should pass a school new" do
      expect(assigns(:school)).to_not eq nil
    end
  end

  describe "#create" do

    context 'when valid' do
      before(:each) do
        post :create, school: attributes_for(:school),
          person: attributes_for(:person), login: attributes_for(:login)
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
  end

  describe "#edit" do
    let(:school) { test_schools[rand 2] }
    before(:each) { get :edit, id: school.id }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the school" do
      expect(assigns(:school)).to eq school
    end
  end

  describe "#update" do
    xit "should be success" do
    end
  end

  describe "#destroy" do
    context 'when requested school exists' do
      let(:school) { test_schools[rand 2] }
      before(:each) { delete :destroy, id: school.id }

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
        expect { get :show, id: -1 }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
