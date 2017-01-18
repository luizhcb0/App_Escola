require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:test_report) { 2.times.map { create(:report) } }

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
    let(:option) { create(:option) }
    let(:student) { create(:student) }

    context "when valid" do
      before(:each) do
        post :create, params: {
          report: attributes_for(:report, student_id: student.id, option_ids: [option.id])
        }
      end

      it "should redirect to reports_path" do
        expect(response).to redirect_to reports_path
      end

      it "should save the report" do
        expect(report).to be_persisted
      end

      it "should save report.options reference" do
        expect(report.options.first).to eq option
      end

      it "should save options.report reference" do
        expect(option.reports.first).to eq report
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: { report: attributes_for(:report, student_id: nil) }
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
    let(:report) { assigns(:report) }
    let(:student) { create(:student) }
    let(:option) { create(:option) }

    context "when valid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(:report, student_id: student.id, option_ids: [option.id]),
          id: report.id
        }
      end

      it "should be success" do
        expect(response).to redirect_to reports_path(report.id)
      end

      it "should update attributes" do
        expect(report.reload.student).to eq student
        expect(report.options.first).to eq option
      end
    end

    context "when invalid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(:report, student_id: -1, option_ids: [option.id]),
          id: report.id
        }
      end

      it "should render edti template" do
        expect(response).to render_template(:edit)
      end

      it "should not update attributes" do
        expect(report.reload.student).to_not eq student
        expect(report.options.size).to eq 0
      end
    end
  end

  describe "DELETE #destroy" do
    context "when requested report exists" do
      let(:option) { create(:option) }
      let(:report) { create(:report, option_ids: [option.id]) }

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

      it "should delete report from option on DB" do
        expect(option.reports.size).to eq 0
      end
    end

    context "when requested report does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        expect{ get :show, params: {id: -1}}.to raise_exception ActiveRecord::RecordNotFound
      end
    end
  end
end
