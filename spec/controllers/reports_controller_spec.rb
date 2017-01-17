require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:test_report) {
    2.times.map {
      create(:report, student: create(:student), report_options_attributes: [
        {option: create(:option), note: "ole" }
      ])
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
      expect(response).to render_template(:index)
    end

    it "should load all reports" do
      expect(assigns(:reports)).to match_array test_report
    end
  end

  describe "GET #show" do
    context "when requested report exists" do
      let(:report) { create(:report) }

      before(:each) do
        get :show, params: { id: report.id }
      end

      it "should be success" do
        expect(response).to be_success
      end

      it "should load the correct report" do
        expect(assigns(:report)).to eq report
      end
    end

    context "when requested report does not exist" do
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

    it "should pass a new report" do
      expect(assigns(:report)).to be_a_new Report
    end
  end

  describe "POST #create" do
    let(:report) { assigns(:report) }
    let(:test_option) { create(:option) }
    let(:test_student) { create(:student) }

    context "when valid" do
      before(:each) do
        post :create, params: {
          report: attributes_for(:report, student_id: test_student.id,
          report_options_attributes: [build(:report_option).attributes]
          )
        }
      end

      it "should redirect to reports_path" do
        expect(response).to redirect_to reports_path
      end

      it "should save the report" do
        expect(report).to be_persisted
      end

      it "should save report_options" do
        expect(report.report_options.first).to be_persisted
        expect(ReportOption.all).to include report.report_options.first
      end

      it "should have saved the correct report_option" do
        expect(report.report_options[0].note).to eq "essa nota"
      end

      it "should have saved with correct references" do
        expect(report.report_options.first.report_id).to eq report.id
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: {
          report: attributes_for(:report,
          report_options_attributes: [build(:report_option).attributes]
          )
        }
      end

      it "should render new template" do
        expect(response).to render_template(:new)
      end

      it "should not save the report" do
        expect(report).to_not be_persisted
        expect(Report.all).to_not include report
      end
    end
  end

  describe "GET #edit" do
    let(:report) { assigns(:report) }
    let(:report) { test_report[rand 2] }

    before(:each) do
      get :edit, params: {id: report.id}
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should load the requested report" do
      expect(assigns(:report)).to eq report
    end
  end

  describe "PATCH #update" do
    let(:report) {assigns(:report)}
    let(:test_student) { create(:student) }
    let(:report_option) { build(:report_option) }

    context "when valid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(
            :report, student_id: test_student.id,
            report_options_attributes: [build(:report_option).attributes]
          ),
          id: report.id
        }
      end

      it "should be success" do
        expect(response).to redirect_to reports_path(report.id)
      end

      it "should update attributes" do
        expect(report.student_id).to eq test_student.id
        expect(report.report_options[0].note).to eq "essa nota"
      end
    end

    context "when invalid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(
            :report, student_id: -1,
            report_options: [report_option]
          ),
          id: report.id
        }
      end

      it "should render edti template" do
        expect(response).to render_template(:edit)
      end

      it "should not update attributes" do
        expect(report.student_id).to_not eq test_student.id
        expect(report.report_options.size).to eq 0
      end
    end
  end

  describe "DELETE #destroy" do
    context "when requested report exists" do
      let(:report) { create(:report, report_options_attributes: [
        {option: create(:option), note: "bilu" }
      ]) }


      before(:each) do
        delete :destroy, params: { id: report.id }
      end

      it "should redirect to reports_path" do
        expect(response).to redirect_to reports_path
      end

      it "should delete the requested report from DB" do
        expect(Report.all).to_not include report
        expect{report.reload}.to raise_exception ActiveRecord::RecordNotFound
      end

      it "should delete report_options from DB" do
        expect(ReportOption.all).to_not include report.report_options[0]
      end
    end

    context "when requested report does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{ get :show, params: {id: -1}}.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end
end
