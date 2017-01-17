require 'rails_helper'

RSpec.describe OptionsController, type: :controller do
  let (:test_option) { 2.times.map { create(:option, activity: create(:activity), parent: nil) } }
  let (:test_activity) { create(:activity, activity_category: create(:activity_category), classrooms: [create(:classroom)]) }
  let(:test_children) {
    2.times.map {
      create(:option, activity: create(:activity), parent: test_option[0])
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

    it "should load just parent options" do
      expect(assigns(:options)).to match_array test_option
    end

    it "should not load all options" do
      expect(assigns(:options)).to_not match_array test_children
    end
  end

  describe "GET #show" do
    context "when requested option exists" do
      let(:option) { create(:option) }

      before(:each) do
        get :show, params: { id: option.id }
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the correct option" do
        expect(assigns(:option)).to eq option
      end
    end

    context "when requested option does not exist" do
      it "throws ActiveRecord::RecordNotFound exception" do
        expect{ get :show, params:{ id: -1 } }.to raise_exception ActiveRecord::RecordNotFound
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

    it "should pass a new option" do
      expect(assigns(:option)).to_not eq nil
    end

  end

  describe "POST #create" do
    let(:option) { assigns(:option) }

    context "when valid" do
      before(:each) do
        post :create, params: {
          option: attributes_for(:option, name: "opt", activity_id: test_activity.id,
            suboptions_attributes: [build(:option).attributes]
          )
        }
      end

      it "should redirect to options_path" do
        expect(response).to redirect_to options_path
      end

      it "should save the option" do
        expect(option).to be_persisted
      end

      it "should have saved the correct suboption" do
        expect(option.suboptions[0].name).to eq "Cagou Muito"
      end

      it "should save suboptions" do
        expect(option.suboptions.first).to be_persisted
        expect(Option.all).to include option.suboptions.first
      end

      it "should have saved the same activity_id for parent and children" do
        expect(option.suboptions.first.activity_id).to eq option.activity_id
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: {
          option: attributes_for(:option, name: "", activity_id: test_activity.id,
            suboptions_attributes: [build(:option).attributes]
          )
        }
      end

      it "should render new template" do
        expect(response).to render_template("new")
      end

      it "should not save the option" do
        expect(option).to_not be_persisted
      end

      it "should not save suboptions" do
        expect(option.suboptions.first).to_not be_persisted
        expect(Option.all).to_not include option.suboptions[0]
      end
    end

  end

  describe "GET #edit" do
    let(:option) {test_option[rand 2]}

    before(:each) do
      get :edit, params: {id: option.id}
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the requested option" do
      expect(assigns(:option)).to eq option
    end

  end

# STUDY this: which option is each??
  describe "PATCH #update" do
    let(:option) { assigns(:option) }
    let(:activity) { create(:activity) }
    let(:option_child) { create(:option) }

    context "when valid" do
      before(:each) do
        option = create(:option)
        patch :update, params: {
          option: attributes_for(
            :option, name: "Urina", activity_id: activity.id,
              suboptions_attributes: [build(:option).attributes]
          ),
          id: option.id
        }
      end

      it "should be success" do
        expect(response).to redirect_to options_path(option.id)
      end

      it "should update attributes" do
        expect(option.name).to eq "Urina"
        expect(option.activity_id).to eq activity.id
        expect(option.suboptions.first.name).to eq "Cagou Muito"
      end
    end

    context "when invalid" do
      before(:each) do
        option = create(:option)
        patch :update, params: {
          option: attributes_for(
            :option, name: "", activity_id: activity.id,
              suboptions_attributes: [build(:option).attributes]
          ),
          id: option.id
        }
      end

      it "should render edit template" do
        expect(response).to render_template("edit")
      end

      it "should not update attributes" do
        expect(option.reload.name).to_not eq ""
        expect(option.reload.activity_id).to_not eq activity.id
        expect(option.reload.suboptions).to eq []
      end
    end
  end

  describe "DELETE #destroy" do
    context "when requested option exists" do
      let(:child) { create(:option) }
      let(:child2) { create(:option) }
      let(:option) { create(:option, suboptions: [child, child2])}

      before(:each) do
        delete :destroy, params: {id: option.id}
      end

      it "should redirect to options_path" do
        expect(response).to redirect_to options_path
      end

      it "should delete the requested option from DB" do
        expect(Option.all).to_not include option
        expect{option.reload}.to raise_exception ActiveRecord::RecordNotFound
      end

      it "should delete suboptions from DB" do
        expect(Option.all).to_not include child
        expect{child.reload}.to raise_exception ActiveRecord::RecordNotFound
        expect(Option.all).to_not include child2
        expect{child2.reload}.to raise_exception ActiveRecord::RecordNotFound
      end
    end

    context "when requested option does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{ get :show, params: {id: -1}}.to raise_exception ActiveRecord::RecordNotFound
      end
    end

  end

end
