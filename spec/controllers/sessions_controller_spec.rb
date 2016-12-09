require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    before(:each) { get :new }

    it "should be success" do
      expect(response).to be_success
    end

    it "should render new template(the login template)" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) { create(:login) }
    let(:login) { assigns(:login) }

    context "when valid" do
      before(:each) { post :create, params: attributes_for(:login) }

      it "should redirect successfully" do
        expect(response).to redirect_to schools_path #change it latter
      end

      it "should set session login_id with the right id" do
        expect(session[:login_id]).to eq login.id
      end
    end

    context "when invalid" do
      before(:each) { post :create, params: attributes_for(:login,
        username: "invalid", password: "notright") }

      it "should render new template(the login template)" do
        expect(response).to render_template("new")
      end

      it "shouldn't set the session login_id" do
        expect(session[:login_id]).to eq nil
      end
    end

    context "when only password is invalid" do
      before(:each) { post :create, params: attributes_for(:login,
        password: "notright") }

      it "should render new template(the login template)" do
        expect(response).to render_template("new")
      end

      it "shouldnt login with the wrong password" do
        expect(session[:login_id]).to eq nil
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete the session login_id" do
      session[:login_id] = 1
      expect(session[:login_id]).to eq 1
      delete :destroy
      expect(session[:login_id]).to eq nil
    end

    it "should redirect to new session path" do
      delete :destroy
      expect(response).to redirect_to new_session_path
    end
  end

end
