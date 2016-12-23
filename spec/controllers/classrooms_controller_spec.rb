require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:test_classrooms) { 2.times.map { create (:classroom) } }

  describe "GET #index" do
    before (:each) { get :index }

    it "should be success" do
      expect(response).to be_success
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should load all classrooms" do
      expect(assigns(:classrooms)).to match_array test_classrooms
    end
  end

  describe "GET #show" do
    context 'when requested school exists' do
      let(:classroom) { test_classrooms[rand 2] }
      before(:each) { get :show, params: { id: classroom.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load school" do
        expect(assigns(:classroom)).to eq classroom
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
      expect(assigns(:classroom)).to_not eq nil
    end
  end


  describe "POST #create" do
    let(:classroom) { assigns(:classroom) }

    context 'when valid' do
      before(:each) { post :create, params: { classroom: attributes_for(:classroom) } }

      it "should redirect to classrooms_path" do
        expect(response).to redirect_to(classrooms_path)
      end

      it "should save the classroom" do
        expect(classroom).to_not be nil
        expect(classroom).to be_persisted
      end
    end

    context 'when invalid' do
      before(:each) { post :create, params: {
        classroom: attributes_for(:classroom, name: "") } }

      it { expect(response).to render_template(:new) }
      it { expect(classroom).to_not be_persisted }
    end
  end

  describe "GET #edit" do
    let(:classroom) { test_classrooms[rand 2] }
    before(:each) { get :edit, params: { id: classroom.id } }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the school" do
      expect(assigns(:classroom)).to eq classroom
    end
  end


  describe "PATCH #update" do
    let(:classroom) { assigns(:classroom) }

    context 'when valid' do
      before(:each) do
        classroom = create(:classroom)
        patch :update, params: {
          classroom: attributes_for(:classroom ,name: "salinha", shift: "vespertino"),
          id: classroom.id }
      end

      it "should be success" do
        expect(response).to redirect_to(classrooms_path(classroom.id))
      end

      it "should update attributes" do
        expect(classroom.name).to eq "salinha"
        expect(classroom.shift).to eq "vespertino"
      end
    end

    context 'when invalid' do
      before(:each) do
        classroom = create(:classroom)
        patch :update, params: {
          classroom: attributes_for(:classroom ,name: "", shift: "vespertino"),
          id: classroom.id }
      end

      it { expect(response).to render_template(:edit) }

      it "shouldn't change classroom" do
        expect(classroom.reload.shift).to_not eq "vespertino"
      end
    end
  end

  describe "DELETE #destroy" do
    context 'when requested classroom exists' do
      let(:classroom) { test_classrooms[rand 2] }
      before(:each) { delete :destroy, params: { id: classroom.id } }

      it "should redirect to classrooms_path" do
        expect(response).to redirect_to(classrooms_path)
      end

      it "should have deleted the classroom from the DB" do
        expect(Classroom.all).not_to include classroom
        expect { classroom.reload }.to raise_exception ActiveRecord::RecordNotFound
      end

      xit "should delete dependents from DB" do
      end
    end

    context 'when requested classroom does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
