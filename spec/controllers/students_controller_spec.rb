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
      let(:user) { create(:user) }
      let(:student) { create(:student, users: [user]) }
      before(:each) { get :show, params: { id: student.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load student" do
        expect(assigns(:student)).to eq student
      end

      it "should load student user" do
        expect(assigns(:user)).to eq user
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

    it "should pass a new student" do
      expect(assigns(:student)).to_not eq nil
    end

    it "should pass a new user" do
      expect(assigns(:user)).to_not eq nil
    end
  end

  describe "POST #create" do
    let(:student) { assigns(:student) }
    context 'when valid' do
      before(:each) { post :create, params: {
        student: attributes_for(:student), user: attributes_for(:user) } }

      it "should redirect to students_path" do
        expect(response).to redirect_to(students_path)
      end

      it "should save student" do
        expect(student).to be_persisted
      end

      it "should save a valid student" do
        expect(student.name).to eq "Student"
      end

      it "should save the user" do
        expect(student.users.first).to be_persisted
        expect(student.users.first.name).to eq "User"
      end
    end

    context 'when email is invalid' do
      before(:each) { post :create, params: { student: attributes_for(:student),
        user: attributes_for(:user, email: "abc.com") } }

      it { expect(response).to render_template(:new) }
      it { expect(student).to_not be_persisted }
    end
  end

  describe "GET #edit" do
    let(:user) { create(:user) }
    let(:student) { create(:student, users: [user]) }
    before(:each) { get :edit, params: { id: student.id } }

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the student" do
      expect(assigns(:student)).to eq student
    end

    it "should load the student user" do
      expect(assigns(:user)).to eq user
    end
  end

  describe "PATCH #update" do
    let(:student) { assigns(:student) }

    context 'when valid' do
      before(:each) do
        student = create(:student, users: [(create(:user))])
        patch :update, params: {
          student: attributes_for(:student, name: "Student2"),
          user: attributes_for(:user, name: "User2"), id: student.id }
      end

      it "should be success" do
        expect(response).to redirect_to(students_path(student.id))
      end

      it "should update student attributes" do
        expect(student.name).to eq "Student2"
      end

      it "should update user attributes" do
        expect(student.users.first.name).to eq "User2"
      end
    end

    context 'when email is invalid' do
      before(:each) do
        student = create(:student, users: [(create(:user))])
        patch :update, params: {
          student: attributes_for(:student, name: "Student2"),
          user: attributes_for(:user, name: "User2", email: "abc.com"),
          id: student.id }
      end

      it { expect(response).to render_template(:edit) }

      it "shouldn't change student" do
        expect(student.reload.name).to_not eq "Student2"
      end

      it "shouldn't change student user" do
        expect(student.reload.users.first.name).to_not eq "User2"
        expect(student.users.first.email).to_not eq "abc.com"
      end
    end
  end

  describe "PATCH #set_presence" do
    let(:student) { assigns(:student) }

    context "when student is present" do
      before(:each) do
        student = create(:student)
        patch :set_presence,
          params: {
            id: student.id, status: "false"
          }
      end

      it "should set absence to false" do
        expect(student.absence).to be false
      end

      it "redirects to the new_report_path" do
        expect(response).to redirect_to new_report_path
      end
    end

    context "when student is absent" do
      before(:each) do
        student = create(:student)
        patch :set_presence,
          params: {
            id: student.id, status: "true"
          }
      end

      # Did not understant why it is not working... Callback??
      it "should set absence to true" do
        expect(student.absence).to eq true
      end

      it "redirects to the new_report_path" do
        expect(response).to redirect_to new_report_path
      end
    end

  end

  describe "DELETE #destroy" do
    context 'when requested student exists' do
      let(:student) { test_students[rand 2] }
      before(:each) { delete :destroy, params: { id: student.id } }

      it "should redirect to students_path" do
        expect(response).to redirect_to(students_path)
      end

      it "should have deleted the student from the DB" do
        expect(Student.all).not_to include student
        expect { student.reload }.to raise_exception ActiveRecord::RecordNotFound
      end

      xit "should delete dependents from DB" do
      end
    end

    context 'when requested student does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
