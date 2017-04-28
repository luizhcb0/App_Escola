require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:test_report) { 2.times.map { create(:report) } }

  describe "GET #index" do
    before(:each) do
      get :index, params: { student_id: test_report[0].student_id }
    end

    it "should be success" do
      expect(response).to be_success
    end

    it "should render index template" do
      expect(response).to render_template(:index)
    end

    it "should load all reports" do
      expect(assigns(:reports)).to match_array test_report[0].student.reports
    end
  end

  describe "GET #show" do
    context "when requested report exists" do
      let(:report) { create(:report) }

      before(:each) do
        get :show, params: { student_id: report.student_id , date: report.date }
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
        get :show, params: { student_id: -1, date: Date.today }
        expect(assigns(:report)).to eq nil
      end
    end
  end


  describe "POST #search" do
    context "when requested report exists" do
      let(:report) { create(:report) }

      before(:each) do
        post :search, params: { student_id: report.student_id, date: Date.today }
      end

      it "should redirect_to show" do
        expect(response).to redirect_to student_report_path(report.student_id, report.date)
      end
    end
  end


  describe "POST #send_all" do
    let(:reports) { 3.times.map { create(:report) } }
    let(:students) { reports.map { |rep| rep.student } }
    let(:classroom) { create(:classroom, students: students) }
    before(:each) do
      post :send_all, params: { classroom_id: classroom.id }
    end

    it "saves all reports of that day, for the specific class, as non drafts" do
      expect(reports[0].reload.draft).to be false
      expect(reports[1].reload.draft).to be false
      expect(reports[2].reload.draft).to be false
    end

    it "redirects to the new_report_path" do
      expect(response).to redirect_to new_report_path
    end
  end


  describe "POST #send_clip" do
    let(:reports) { 3.times.map { create(:report) } }
    let(:student_ids) { reports.map { |rep| rep.student.id } }
    let(:photo) { Rails.root.join('spec', 'medias', 'test.png') }

    context "reports exist" do
      before(:each) do
        post :send_clip, params: { student_ids: student_ids, media: fixture_file_upload(photo) }
      end

      it "saves the clip" do
        expect(reports[0].clips[0].reports).to eq reports
        expect(reports[0].clips[0]).to have_attached_file(:media)
        expect(reports[1].clips[0]).to have_attached_file(:media)
        expect(reports[2].clips[0]).to have_attached_file(:media)
      end

      it "redirects to the new_report_path" do
        expect(response).to redirect_to new_report_path
      end
    end

    context "report does not exist yet" do
      let (:student) { create(:student) }
      before(:each) do
        post :send_clip, params: { student_ids: [student.id], media: fixture_file_upload(photo) }
      end

      it "saves the clip" do
        expect(student.reports).to_not eq nil
        expect(Clip.all.size).to eq 1
        expect(Clip.all[0].reports[0].student).to eq student
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
    let(:reports) { assigns(:reports) }
    let(:suboption) { create(:suboption) }
    let(:student) { create(:student) }

    context "when valid" do
      before(:each) do
        post :create, params: {
          student_ids: [student.id],
          report: attributes_for(:report,
            suboption_ids: [suboption.id],
            report_notes_attributes: [build(:report_note).attributes])
        }
      end

      it "should redirect_to new report" do
        expect(response).to redirect_to new_report_path
      end

      it "should belong to the right student" do
        expect(reports[0].student_id).to eq student.id
      end

      it "should save the report" do
        expect(reports[0]).to be_persisted
      end

      it "should save the report_note" do
        expect(reports[0].report_notes.count).to eq 1
      end

      it "should save report.suboptions reference" do
        expect(reports[0].suboptions.first).to eq suboption
      end

      it "should save suboptions.report reference" do
        expect(suboption.reports.first).to eq reports[0]
      end
    end

    context "when invalid" do
      before(:each) do
        post :create, params: { report: attributes_for(:report) }
      end

      it "should redirect_to new_report_path" do
        expect(response).to redirect_to(new_report_path)
      end

      it "should not save the report" do
        expect(reports[0]).to eq nil
        # expect(report).to_not be_persisted
        # expect(Report.all).to_not include report
      end
    end
  end

  describe "GET #edit" do
    let(:report) { assigns(:report) }
    let(:report) { test_report[rand 2] }

    before(:each) do
      get :edit, params: {student_id: report.student_id, date: report.date}
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
    let(:suboption) { create(:suboption) }

    context "when valid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(:report, student_id: student.id,
            suboption_ids: [suboption.id],
            report_notes_attributes: [build(:report_note, text: "new note").attributes]),
          student_id: report.student_id, date: report.date
        }
      end

      it "should be success" do
        expect(response).to redirect_to student_report_path(report.student_id,report.date)
      end

      it "should update attributes" do
        expect(report.reload.student).to eq student
        expect(report.suboptions.first).to eq suboption
        expect(report.report_notes.first.text).to eq "new note"
      end
    end

    context "when invalid" do
      before(:each) do
        report = create(:report)
        patch :update, params: {
          report: attributes_for(:report, student_id: -1,
            suboption_ids: [suboption.id, create(:suboption).id],
            report_notes_attributes: [build(:report_note).attributes]),
          student_id: report.student_id, date: report.date
        }
      end

      it "should render edit template" do
        expect(response).to render_template(:edit)
      end

      it "should not update attributes" do
        expect(report.reload.student).to_not eq student
        expect(report.suboptions.size).to eq 1
      end
    end
  end

  describe "DELETE #destroy" do
    context "when requested report exists" do
      let(:suboption) { create(:suboption) }
      let(:report) { create(:report, suboption_ids: [suboption.id]) }

      before(:each) do
        delete :destroy, params: { student_id: report.student_id, date: report.date }
      end

      it "should redirect to reports_path" do
        expect(response).to redirect_to root_path
      end

      it "should delete the requested report from DB" do
        expect(Report.all).to_not include report
        expect{report.reload}.to raise_exception ActiveRecord::RecordNotFound
      end

      it "should delete report from option on DB" do
        expect(suboption.reports.size).to eq 0
      end
    end

    context "when requested report does not exist" do
      it "should throw ActiveRecord::RecordNotFound exception" do
        delete :destroy, params: {student_id: -1, date: Date.today}
        expect(assigns(:report)).to eq nil
      end
    end
  end
end
