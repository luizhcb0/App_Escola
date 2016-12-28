require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:test_messages) { 2.times.map { create (:message) } }

  describe "GET #index" do
    before(:each) {
      user = FactoryGirl.create(:user)
      controller.session[:user_id] = user.id
      get :index
    }

    it "should be success" do
      expect(response).to be_success
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "should load all messages from that session" do
      expect(assigns(:messages)).to match_array test_messages
    end
  end

  describe "GET #show" do
    context 'when requested message exists' do
      let(:message) { test_messages[rand 2] }
      before(:each) { get :show, params: { id: message.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the message" do
        expect(assigns(:message)).to eq message
      end
    end

    context 'when requested message does not exists' do
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

    it "should pass a message new" do
      expect(assigns(:message)).to_not eq nil
    end
  end

  describe "POST #create" do
    let(:message) { assigns(:message) }

    context 'when valid' do
      before(:each) { post :create, params: { message: attributes_for(:message) } }

      it "should redirect to messages_path" do
        expect(response).to redirect_to(messagess_path)
      end

      it "should save the message" do
        expect(message).to_not be nil
        expect(message).to be_persisted
      end

      context 'when invalid' do
        before(:each) {
          post :create, params: {
            message: attributes_for(:message, text: "Mensagem teste")
          }
        }

        it { expect(response).to render_template(:new) }
        it { expect(message).to_not be_persisted }
      end
    end

    describe "GET #edit" do
      let(:message) { test_messages[rand 2] }
      before(:each) { get :edit, params: { id: message.id } }

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the message" do
        expect(assigns(:message)).to eq message
      end
    end

    describe "PATCH #update" do
      let(:message) { assigns(:message) }

      context 'when valid' do
        before(:each) do
          message = create(:message)
          patch :update, params: {
            message: attributes_for(:message ,text: "Mensagem teste"),
            id: message.id }
        end

        it "should be success" do
          expect(response).to redirect_to(messages_path(message.id))
        end

        it "should update attributes" do
          expect(message.name).to eq "Mensagem teste"
        end
      end

      context 'when invalid' do
        before(:each) do
          message = create(:message)
          patch :update, params: {
            message: attributes_for(:message),
            id: message.id }
        end

        it { expect(response).to render_template(:edit) }

        it "shouldn't change message" do
          expect(message.reload.text).to_not eq ""
        end
      end
    end

    describe "DELETE #destroy" do
      context 'when requested message exists' do
        let(:message) { test_messages[rand 2] }
        before(:each) { delete :destroy, params: { id: message.id } }

        it "should redirect to messages_path" do
          expect(response).to redirect_to(messages_path)
        end

        it "should have deleted the message from the DB" do
          expect(Message.all).not_to include message
          expect { message.reload }.to raise_exception ActiveRecord::RecordNotFound
        end

        xit "should delete dependents from DB" do
        end
      end

      context 'when requested message does not exists' do
        it 'throws ActiveRecord::RecordNotFound' do
          expect { get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
