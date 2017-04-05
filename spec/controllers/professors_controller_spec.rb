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
    let(:professor) { assigns(:professor) }
    context 'when valid' do
      let(:classroom) { create(:classroom) }
      before(:each) { post :create, params: { professor: attributes_for(:professor,
        classroom_id: classroom.id ) } }

      it "should redirect to professors_path" do
        expect(response).to redirect_to(professors_path)
      end

      it "should save the professor" do
        expect(professor).to_not be nil
        expect(professor).to be_persisted
        expect(professor.name).to eq "Prof"
        expect(professor.classroom_id).to eq classroom.id
      end
    end

    context 'when name is invalid' do
      before(:each) { post :create, params: { professor: attributes_for(:professor, name: "") } }

      it { expect(response).to render_template(:new) }
      it { expect(professor).to_not be_persisted }
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
    let(:professor) { assigns(:professor) }
    context 'when valid' do
      let(:classroom) { create(:classroom) }
      before(:each) do
        professor = create(:professor)
        patch :update, params: {
          professor: attributes_for(:professor, name: "Prof2", classroom_id: classroom.id),
          id: professor.id }
      end

      it "should be success" do
        expect(response).to redirect_to(professors_path(professor.id))
      end

      it "should update user attributes" do
        expect(professor.name).to eq "Prof2"
        expect(professor.classroom_id).to eq classroom.id
      end
    end

    context 'when name is invalid' do
      before(:each) do
        professor = create(:professor)
        patch :update, params: { professor: attributes_for(:professor, name: ""),
          id: professor.id }
      end

      it { expect(response).to render_template(:edit) }

      it "shouldn't change professor" do
        expect(professor.reload.name).to eq "Prof"
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
    end

    context 'when requested professor does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
