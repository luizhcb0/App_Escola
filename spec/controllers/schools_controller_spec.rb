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
    let(:school) { assigns(:school) }

    context 'when valid' do
      before(:each) do post :create, params: {
        school: attributes_for(:school), user: attributes_for(:user, :fixed) }
      end

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

      it "should save a valid professor(principal) user" do
        expect(school.professor.user).to_not be nil
        expect(school.professor.user).to be_persisted
        expect(school.professor.user.name).to eq "User"
        expect(school.professor.user.email).to eq "email@example.com"
        expect(school.professor.user.authenticate("12345678")).to eq school.professor.user
        expect(school.professor.user.role.name).to eq "principal"
      end
    end

    context 'when email is invalid' do
      before(:each) { post :create, params: { school: attributes_for(:school),
        user: attributes_for(:user, email: "abc.com") } }

      it { expect(response).to render_template(:new) }
      it { expect(school).to_not be_persisted }
      it { expect(school.professor).to_not be_persisted }
      it { expect(school.professor.user).to_not be_persisted }
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
    let(:school) { assigns(:school) }

    context 'when valid' do
      before(:each) do
        school = create(:school)
        patch :update, params: {
          school: attributes_for(:school, name: "Teste2"),
          user: attributes_for(:user, name: "User2", email: "test@gmail.com",
            password: "654321", password_confirmation: "654321"),
          id: school.id }
      end

      it "should be success" do
        expect(response).to redirect_to(schools_path(school.id))
      end

      it "should update school attributes" do
        expect(school.name).to eq "Teste2"
      end

      it "should update user attributes" do
        expect(school.professor.user.name).to eq "User2"
        expect(school.professor.user.email).to eq "test@gmail.com"
        expect(school.professor.user.password).to eq "654321"
      end
    end

    context 'when email is invalid' do
      before(:each) do
        school = create(:school)
        patch :update, params: {
          school: attributes_for(:school, name: "Teste2"),
          user: attributes_for(:user, name: "User2", email: "abc.com"),
          id: school.id }
      end

      it { expect(response).to render_template(:edit) }

      it "shouldn't change school" do
        expect(school.reload.name).to_not eq "Teste2"
      end

      it "shouldn't change school professor user" do
        expect(school.reload.professor.reload.user.name).to_not eq "User2"
        expect(school.professor.user.email).to_not eq "abc.com"
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

      xit "should delete dependents from DB" do
      end
    end

    context 'when requested school does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
