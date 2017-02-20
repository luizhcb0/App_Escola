require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before(:each) { get :new }

    it "should be success" do
      expect(response).to be_success
    end

    it "should render new template(the user template)" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) { create(:user, :fixed) }
    let(:user) { assigns(:user) }

    context "when valid" do
      before(:each) { post :create, params: attributes_for(:user, :fixed) }

      it "should redirect successfully" do
        expect(response).to redirect_to root_path #change it latter
      end

      it "should set session user_id with the right id" do
        expect(session[:user_id]).to eq user.id
      end
    end

    context "when invalid" do
      before(:each) { post :create, params: attributes_for(:user,
        email: "invalid", password: "notright") }

      it "should render new template(the user template)" do
        expect(response).to render_template("new")
      end

      it "shouldn't set the session user_id" do
        expect(session[:user_id]).to eq nil
      end
    end

    context "when only password is invalid" do
      before(:each) { post :create, params: attributes_for(:user, :fixed,
        password: "notright") }

      it "should render new template(the user template)" do
        expect(response).to render_template("new")
      end

      it "shouldnt user with the wrong password" do
        expect(session[:user_id]).to eq nil
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete the session user_id" do
      session[:user_id] = 1
      expect(session[:user_id]).to eq 1
      delete :destroy
      expect(session[:user_id]).to eq nil
    end

    it "should redirect to new session path" do
      delete :destroy
      expect(response).to redirect_to new_session_path
    end
  end

end
