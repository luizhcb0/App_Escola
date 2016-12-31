require 'rails_helper'

RSpec.describe ActivityCategoriesController, type: :controller do
  let(:test_category) { 2.times.map { create(:activity_category) } }

  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should reder index template" do
      expect(response).to render_template("index")
    end

# Assigns works with controller variable
    it "should load all categories" do
      expect(assigns(:activity_categories)).to match_array test_category
    end
  end

  describe "GET #show" do
    let(:category) { create(:activity_category) }

    context "when requested category exists" do
      before(:each) do
        get :show, params: { id: category.id }
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the correct category" do
        expect(assigns(:activity_category)).to eq category
      end
    end

    context "when requested category does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{ get :show, params: { id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
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

    it "should pass a new category" do
      expect(assigns(:activity_category)).to_not eq nil
    end

  end

  describe "POST #create" do
    let(:category) { assigns(:activity_category) }

    context "when valid" do
      before(:each) do
        post :create, params: { activity_category: build(:activity_category).attributes }
      end

      it "should redirect to activity_categories_path" do
        expect(response).to redirect_to activity_categories_path
      end

      it "should save the category" do
          expect(category).to be_persisted
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: { activity_category: attributes_for(:activity_category, name: "")}
      end

      it "should render new template" do
        expect(response).to render_template("new")
      end

      it "should not save the category" do
        expect(category).to_not be_persisted
      end
    end

  end

  describe "GET #edit" do
    let(:category) { test_category[rand 2] }

    before(:each) do
      get :edit, params: { id: category.id }
    end

    it "should be succuess" do
      expect(response).to be_success
    end

    it "should load the requested category" do
      expect(assigns(:activity_category)).to eq category
    end

  end

  describe "PATCH #update" do
    let(:category) { assigns(:activity_category) }

    context "when valid" do
      before(:each) do
        category = create(:activity_category)
        patch :update, params: {
          activity_category: attributes_for(:activity_category, name: "Administrativo"),
          id: category.id
        }
      end

      it "should redirect to activity_categories_path(category.id)" do
        expect(response).to redirect_to activity_categories_path(category.id)
      end

      it "should update all attributes" do
        expect(category.name).to eq "Administrativo"
      end
    end

    context "when invalid" do
      before(:each) do
        category = create(:activity_category)
        patch :update, params: {
          activity_category: attributes_for(:activity_category, name: ""),
          id: category.id
        }
      end

      it "should render edit template" do
        expect(response).to render_template("edit")
      end

      it "should not update attributes" do
        expect(category.reload.name).to_not eq ""
      end

    end

  end

  describe "DELETE #destroy" do
    context "when requested category exists" do
      let (:category) { test_category[rand 2] }

      before(:each) do
        delete :destroy, params: { id: category.id }
      end

      it "should redirect to activity_categories_path" do
        expect(response).to redirect_to activity_categories_path
      end

      it "should delete the requested category from DB" do
        expect(ActivityCategory.all).to_not include category
        expect{ category.reload }.to raise_exception ActiveRecord::RecordNotFound
      end

      xit "should delete all dependents from DB" do

      end

    end

    context "when requested category does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{get :show, params: {id: -1} }.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
