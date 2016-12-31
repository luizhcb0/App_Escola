require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  let(:test_activity) {
    2.times.map {
      create(:activity,
        activity_category: create(:activity_category),
        classrooms: [create(:classroom)]
      )
    }
  }

  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render index template" do
      expect(response).to render_template("index")
    end

    it "should load all activities" do
      expect(assigns(:activities)).to match_array test_activity
    end
  end

  describe "GET #show" do
    context "when requested activity exists" do
      let(:activity) { create(:activity) }

      before(:each) do
        get :show, params: {
          id: activity.id
        }
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the correct activity" do
        expect(assigns(:activity)).to eq activity
      end
    end

    context "when requested activity does not exist" do
      it "throws ActiveRecord::RecordNotFound exception" do
        expect{get :show, params: {id: -1} }.to raise_exception ActiveRecord::RecordNotFound
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

    it "should pass a new activity" do
      expect(assigns(:activity)).not_to eq nil
    end
  end

  describe "POST #create" do
    let(:activity) { assigns(:activity) }

    context "when valid" do
      before(:each) do
        post :create, params: { activity: build(:activity).attributes }
      end

      it "should redirect to activities_path" do
        expect(response).to redirect_to activities_path
      end

      it "should save the activity" do
        expect(activity).to be_persisted
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: {
          activity: attributes_for(:activity, name: "", activity_category: create(:activity_category))
        }
      end

      it "should render index" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    let (:activity) { test_activity[rand 2] }

    before(:each) do
      get :edit, params: {
        id: activity.id
      }
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the requested activity" do
      expect(assigns(:activity)).to eq activity
    end
  end

  describe "PATCH #update" do
    let(:activity) {assigns(:activity)}
    let(:cla) { create(:classroom) }
    let(:cat) { create(:activity_category) }

    context "when valid" do
      before(:each) do
        activity = create(:activity)
        patch :update, params: {
          activity: attributes_for(
            :activity,
            name: "Fralda",
            classroom_ids: [cla.id],
            activity_category_id: cat.id
          ),
          id: activity.id
        }
      end

      it "should be success" do
        expect(response).to redirect_to activities_path(activity.id)
      end

      it "should update attributes" do
        expect(activity.name).to eq "Fralda"
        expect(activity.activity_category_id).to eq cat.id
        expect(activity.classroom_ids).to eq [cla.id]
      end
    end

    context "when invalid" do
      before(:each) do
        activity = create(:activity)
        patch :update, params: {
          activity: attributes_for(
            :activity,
            name: "",
            classroom_ids: [cla.id],
            activity_category_id: cat.id
          ),
          id: activity.id
        }
      end

      it "should render edit" do
        expect(response).to render_template(:edit)
      end

      it "should not change the activity" do
        expect(activity.reload.name).not_to eq ""
      end
    end
  end

  describe "DELETE #destroy" do
    context "when requested activity exists" do
      let(:activity) {test_activity[rand 2]}

      before(:each) do
        delete :destroy, params: {
          id: activity.id
        }
      end

      it "should redirect to activities_path" do
        expect(response).to redirect_to activities_path
      end

      it "should delete the activity from the DB" do
        expect(Activity.all).not_to include activity
        expect{activity.reload}.to raise_exception ActiveRecord::RecordNotFound
      end

      xit "should delete dependents from DB" do
      end

    end

    context "when requested activity does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{get :show, params: {id: -1}}.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end

end
