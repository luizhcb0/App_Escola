require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let (:test_msg_professor) { 2.times.map { create(:message, professor: test_professor) } }
  let (:test_msg_student) { 2.times.map { create(:message, students: [test_student]) } }

  let (:test_professor) { create(:professor, user: create(:user, role: create(:role, name: "professor"))) }
  let (:test_student) { create(:student, users: [create(:user, role: create(:role, name: "student"))]) }

  describe "GET #index for professor" do

    before(:each) do
      session[:user_id] = test_professor.user.id
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render the index template" do
      expect(response).to render_template("index")
    end

    it "should load all messages on from this session" do
      expect(assigns(:messages)).to match_array test_msg_professor
    end

  end

  describe "GET #index for student" do

    before(:each) do
      session[:user_id] = test_student.users.first.id
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render the index template" do
      expect(response).to render_template("index")
    end

    it "should load all messages on from this session" do
      expect(assigns(:messages)).to match_array test_msg_student
    end

  end

  describe "GET show" do
    context "when requested message exists" do
      let(:message) { create (:message) }
      before(:each) {
        get :show, params: {id: message.id}
      }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load message" do
        expect(assigns(:message)).to eq message
      end
    end

    context "when requested message does not exist" do
      it "throws ActiveRecord::RecordNotFound" do
        expect{ get :show, params: { id: -1} }.to raise_exception ActiveRecord::RecordNotFound
      end
    end

  end

  describe "GET #new" do
    before(:each) do
      get :new
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should pass a new message" do
      expect(assigns(:message)).to_not eq nil
    end
  end

  describe "POST #create" do
    let(:message) {assigns(:message)}

    context "when valid" do
      before(:each) do
        session[:user_id] = test_professor.user.id
        # post :create, params: { message: build(:message).attributes }
        post :create, params: {
           message: attributes_for(
            :message,
            professor_id: test_professor.id,
            student_ids: [test_student.id]
          )
        }
      end

      it "should redirect to messages_path" do
        expect(response).to redirect_to(messages_path)
      end

      it "should save message" do
        expect(message).to be_persisted
      end

      it "should have the correct professor_id from user session" do
        expect(message.professor_id).to eq test_professor.id
      end

      it "should send the message to the correct students" do
        expect(message.student_ids).to eq [test_student.id]
      end
    end

    context "when text is invalid" do
      before(:each) do
        post :create, params: {
          message: attributes_for(:message, text: "", professor_id: test_professor.id)
        }
      end

      it "should render new" do
        expect(response).to render_template("new")
      end
    end

    context "when professor_id is missing" do
      before(:each) do
        post :create, params: {
          message: attributes_for(:message)
        }
      end

      it "should render new" do
        expect(response).to render_template("new")
      end
    end

  end

  describe "GET #edit" do
    let(:message) {test_msg_professor[rand 2]}

    before(:each) do
      get :edit, params: {
        id: message.id
      }
    end

    it "should be success" do
      expect(response).to be_success
    end

# :message came from controller and message came from let
# Search how assigns works
    it "should load the message" do
      expect(assigns(:message)).to eq message
    end
  end

  describe "PATCH #update" do
    let(:message) { assigns(:message) }

    context "when valid" do
      before(:each) do
        message = create(:message)
        patch :update, params: {
          message: attributes_for(
            :message,
            text: "mudei",
            professor_id: test_professor.id,
            student_ids: [test_student.id]
          ),
          id: message.id
        }
      end

      it "should be success" do
        expect(response).to redirect_to(messages_path(message.id))
      end

      it "should update attributes" do
        expect(message.text).to eq "mudei"
        expect(message.professor_id).to eq test_professor.id
      end

      it "should update students" do
        expect(message.student_ids).to eq [test_student.id]
      end

    end

    context "when invalid" do
      before(:each) do
        message = create(:message)
        patch :update, params: {
          message: attributes_for(:message, text: ""),
          id: message.id
        }
      end

      it "should render edit" do
        expect(response).to render_template(:edit)
      end

      it "should not change message" do
        expect(message.reload.text).not_to eq ""
      end
    end

  end

  describe "DELETE #destroy" do

    context "when requested message exists" do
      let(:message) { test_msg_professor[rand 2] }

      before(:each) do
        delete :destroy, params: {
          id: message.id
        }
      end

      it "should redirect to messages_path" do
        expect(response).to redirect_to(messages_path)
      end

      it "should delete the message from DB" do
        expect(Message.all).not_to include message
        expect{message.reload}.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context "when requested message does not exist" do

      it "throws ActiveRecord::RecordNotFound" do
        expect {get :show, params: {id: -1}}.to raise_exception ActiveRecord::RecordNotFound
      end
    end

  end

end
