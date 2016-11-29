require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:test_students) { 2.times.map { create(:student) } }

  describe "GET #index" do
    before(:each) { get :index }

    it "should be success" do
      expect(response).to be_success
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should load all students" do
      expect(assigns(:students)).to match_array test_students
    end
  end

  describe "GET #show" do
    context 'when requested student exists' do
      let(:student) { test_students[rand 2] }
      before(:each) { get :show, params: { id: student.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load student" do
        expect(assigns(:student)).to eq student
      end
    end

    context 'when requested student does not exists' do
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

    it "should pass a student new" do
      expect(assigns(:student)).to_not eq nil
    end
  end

  describe "POST #create" do
  end

  describe "GET #edit" do
    let(:student) { test_students[rand 2] }
    before(:each) { get :edit, params: { id: student.id } }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the student" do
      expect(assigns(:student)).to eq student
    end
  end

  describe "PATCH #update" do
  end

  describe "DELETE #destroy" do
  end

end
